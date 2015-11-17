//
//  ItemStore.m
//  TableViewBaseApp
//
//  Created by Zun Wang on 11/14/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import "ItemStore.h"

#import "Item.h"

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
    _allItems = [[NSMutableArray alloc] init];
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
  [_allItems removeObjectAtIndex:index];
}

- (void)moveItemFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
  Item *item = _allItems[fromIndex];
  [self removeItemAtIndex:fromIndex];
  [_allItems insertObject:item atIndex:toIndex];
}

@end
