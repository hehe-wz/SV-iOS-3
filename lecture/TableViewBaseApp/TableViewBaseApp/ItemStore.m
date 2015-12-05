//
//  ItemStore.m
//  TableViewBaseApp
//
//  Created by Zun Wang on 11/14/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import "ItemStore.h"

#import "Item.h"
#import "ImageStore.h"

@import CoreData;

@implementation ItemStore {
  NSMutableArray *_allItems;
  
  NSManagedObjectContext *_context;
  NSManagedObjectModel *_model;
  NSMutableArray *_allAssetTypes;
}

+ (instancetype)sharedStore {
  static ItemStore *sharedStore;
  
  if (sharedStore == nil) {
    sharedStore = [[ItemStore alloc] initPriate];
  }
  
  return sharedStore;
}

- (instancetype)init {
  [NSException raise:@"Wrong init"
              format:@"Please use sharedStore!"];
  return nil;
}

- (instancetype)initPriate {
  if (self = [super init]) {
//    _allItems = [[NSMutableArray alloc] init];
//    NSString *path = [self itemArchivePath];
//    _allItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    if (_allItems == nil) {
//      _allItems = [[NSMutableArray alloc] init];
//    }
    _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    NSString *path = [self itemArchivePath];
    [psc addPersistentStoreWithType:NSSQLiteStoreType
                      configuration:nil
                                URL:[NSURL fileURLWithPath:path]
                            options:nil
                              error:nil];
    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _context.persistentStoreCoordinator = psc;
    
    [self loadAllItems];
  }
  return self;
}

#pragma mark - setter and getter

- (NSArray *)allItems {
  return [_allItems copy];
}

#pragma mark - Modify allItems

- (void)createItem {
//  [_allItems addObject:[Item randomItem]];
  double order;
  if (_allItems.count == 0) {
    order = 1.0;
  } else {
    order = [[_allItems lastObject] orderingValue] + 1.0;
  }
  
  Item *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item"
                                                inManagedObjectContext:_context];
  newItem.orderingValue = order;
  [_allItems addObject:newItem];
}

- (void)removeItemAtIndex:(NSUInteger)index {
  [_context deleteObject:_allItems[index]];
  
  [[ImageStore sharedStore] deleteImageForKey:((Item *)_allItems[index]).itemKey];
  [_allItems removeObjectAtIndex:index];
}

- (void)moveItemFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
  Item *item = _allItems[fromIndex];
  [self removeItemAtIndex:fromIndex];
  [_allItems insertObject:item atIndex:toIndex];
  
  double lowerBound;
  if (toIndex == 0) {
    lowerBound = [_allItems[1] orderingValue] - 2.0;
  } else {
    lowerBound = [_allItems[toIndex - 1] orderingValue];
  }
  
  double upperBound;
  if (toIndex == _allItems.count - 1) {
    upperBound = [_allItems[toIndex - 1] orderingValue] + 2.0;
  } else {
    upperBound = [_allItems[toIndex + 1] orderingValue];
  }
  
  item.orderingValue = (lowerBound + upperBound) / 2;
}

- (BOOL)saveChanges {
//  NSString *path = [self itemArchivePath];
//  NSLog(@"Save change at %@", path);
//  return [NSKeyedArchiver archiveRootObject:_allItems toFile:path];
  return [_context save:nil];
}

#pragma mark - get archive path

- (NSString *)itemArchivePath {
  NSArray *documentDirectories =
  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  
  NSString *documentDirectory = [documentDirectories firstObject];
//  return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
  return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

#pragma mark - Core Data

- (void)loadAllItems {
  if (!_allItems) {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue"
                                                         ascending:YES];
    request.sortDescriptors = @[sd];
    
    NSArray *result = [_context executeFetchRequest:request
                                              error:nil];
    _allItems = [result mutableCopy];
  }
}

- (NSArray *)allAssetTypes {
  if (!_allAssetTypes) {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"AssetType"];
    NSArray *result = [_context executeFetchRequest:request
                                              error:nil];
    _allAssetTypes = [result mutableCopy];
  }
  
  if (_allAssetTypes.count == 0) {
    NSManagedObject *type;
    type = [NSEntityDescription insertNewObjectForEntityForName:@"AssetType"
                                         inManagedObjectContext:_context];
    [type setValue:@"Flower" forKey:@"label"];
    [_allAssetTypes addObject:type];
    
    type = [NSEntityDescription insertNewObjectForEntityForName:@"AssetType"
                                         inManagedObjectContext:_context];
    [type setValue:@"Animal" forKey:@"label"];
    [_allAssetTypes addObject:type];
    
    type = [NSEntityDescription insertNewObjectForEntityForName:@"AssetType"
                                         inManagedObjectContext:_context];
    [type setValue:@"Fall" forKey:@"label"];
    [_allAssetTypes addObject:type];
  }
  
  return _allAssetTypes;
}

@end
