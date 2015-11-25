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

@implementation ItemStore {
  NSMutableArray *_allItems;
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
    NSString *path = [self itemArchivePath];
    _allItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (_allItems == nil) {
      _allItems = [[NSMutableArray alloc] init];
    }
  }
  return self;
}

#pragma mark - setter and getter

- (NSArray *)allItems {
  return [_allItems copy];
}

#pragma mark - Modify allItems

- (void)createItem {
  [_allItems addObject:[Item randomItem]];
}

- (void)removeItemAtIndex:(NSUInteger)index {
  [[ImageStore sharedStore] deleteImageForKey:((Item *)_allItems[index]).itemKey];
  [_allItems removeObjectAtIndex:index];
}

- (void)moveItemFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
  Item *item = _allItems[fromIndex];
  [self removeItemAtIndex:fromIndex];
  [_allItems insertObject:item atIndex:toIndex];
}

- (BOOL)saveChanges {
  NSString *path = [self itemArchivePath];
  NSLog(@"Save change at %@", path);
  return [NSKeyedArchiver archiveRootObject:_allItems toFile:path];
}

#pragma mark - get archive path

- (NSString *)itemArchivePath {
  NSArray *documentDirectories =
  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  
  NSString *documentDirectory = [documentDirectories firstObject];
  return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

@end
