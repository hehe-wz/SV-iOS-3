//
//  ChecklistItem.h
//  techbowA2checklistsObjC
//
//  Created by ZhangZehua on 11/20/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//#import "DataModel.h"

@interface ChecklistItem : NSObject <NSCoding>

@property (nonatomic) NSString* text;
@property (nonatomic) BOOL checked;
@property (nonatomic) NSDate* dueDate;
@property (nonatomic) BOOL shouldRemind;
@property (nonatomic) NSInteger itemID;

- (void)encodeWithCoder:(NSCoder *)coder;
- (instancetype)initWithCoder:(NSCoder *)coder;

- (void)dealloc;

- (UILocalNotification *) notificationForThisItem;
- (void) scheduleNotification;
- (void) toggleChecked;

@end


