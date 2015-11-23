//
//  Checklist.h
//  techbowA2checklistsObjC
//
//  Created by ZhangZehua on 11/22/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ChecklistItem.h"

@interface Checklist : NSObject <NSCoding>

@property (nonatomic) NSString* name;
@property (nonatomic) NSMutableArray <ChecklistItem *>*items;
@property (nonatomic) NSString* iconName;

- (instancetype)initWithName: (NSString *) name;
- (instancetype)initWithName:(NSString *)name iconName:(NSString *) iconName;
- (NSInteger) countUncheckedItems;
- (void) sortChecklistItems;

@end
