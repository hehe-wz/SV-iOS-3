//
//  Checklist.h
//  ChecklistsII
//
//  Created by Eric Huang on 11/18/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChecklistItem.h"

@interface Checklist : NSObject <NSCoding>
@property (nonatomic) NSString *iconName;
@property (nonatomic) NSString *name;
@property (nonatomic) NSMutableArray<ChecklistItem *> *items;
-(instancetype)init: (NSString *)name withIconName: (NSString *) iconName;
-(NSInteger)countUncheckedItems;
-(void)sortSingleChecklist;
@end
