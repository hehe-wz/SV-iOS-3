//
//  ItemStore.h
//  TableViewBaseApp
//
//  Created by Zun Wang on 11/14/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemStore : NSObject

+ (instancetype)sharedStore;
@property (nonatomic, strong, readonly) NSArray *allItems;

- (void)createItem;

- (void)removeItemAtIndex:(NSUInteger)index;

- (void)moveItemFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (BOOL)saveChanges;

@end
