//
//  Checklist.m
//  techbowA2checklistsObjC
//
//  Created by ZhangZehua on 11/22/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import "Checklist.h"

@implementation Checklist

- (instancetype)initWithName: (NSString *) name
{
    self = [self initWithName:name iconName:@"No Icon"];
    
    return self;
}

- (instancetype)initWithName:(NSString *)name iconName:(NSString *) iconName
{
    self = [super init];
    if (self) {
        _items = [[NSMutableArray<ChecklistItem *> alloc] init];
        _name = name;
        _iconName = iconName;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self) {
        _name = (NSString *)[coder decodeObjectForKey:@"Name"];
        _items = (NSMutableArray<ChecklistItem *> *)[[coder decodeObjectForKey:@"Items"]mutableCopy];
        _iconName = (NSString *)[coder decodeObjectForKey:@"IconName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_name forKey:@"Name"];
    [coder encodeObject:_items forKey:@"Items"];
    [coder encodeObject:_iconName forKey:@"IconName"];
}

- (NSInteger) countUncheckedItems {
    NSInteger count = 0;
    for (ChecklistItem* item in _items) {
        if (!item.checked) {
            count++;
        }
    }
    return count;
}

- (void) sortChecklistItems {
    
    _items = (NSMutableArray <ChecklistItem *> *)[[_items sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSDate *date1 = [(ChecklistItem *) obj1 dueDate];
        NSDate *date2 = [(ChecklistItem *) obj2 dueDate];
        return [date1 compare: date2];
    }]mutableCopy];
}
@end
