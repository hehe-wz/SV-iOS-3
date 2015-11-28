//
//  ChecklistItem.m
//  techbowA2checklistsObjC
//
//  Created by ZhangZehua on 11/20/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import "ChecklistItem.h"
#import "DataModel.h"

@implementation ChecklistItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.text = nil;
        self.checked = false;
        self.dueDate = [[NSDate alloc] init];
        self.shouldRemind = false;
        
        self.itemID = [DataModel nextChecklistItemID];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.text forKey:@"Text"];
    [coder encodeBool:self.checked forKey:@"Checked"];
    [coder encodeObject:self.dueDate forKey:@"DueDate"];
    [coder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [coder encodeInteger:self.itemID forKey:@"ItemID"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self) {
        self.text = (NSMutableString*)[coder decodeObjectForKey:@"Text"];
        self.checked = [coder decodeBoolForKey:@"Checked"];
        self.dueDate = (NSDate*)[coder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [coder decodeBoolForKey:@"ShouldRemind"];
        self.itemID = [coder decodeIntegerForKey:@"ItemID"];
    }
    return self;
}


- (void)dealloc
{
    UILocalNotification *existingNotification = [self notificationForThisItem];
    
    if (existingNotification != nil) {
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
}

- (UILocalNotification *) notificationForThisItem {
    NSArray *allNotification = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    for (UILocalNotification *notification in allNotification) {
        NSNumber *number = (NSNumber*)[[notification userInfo] objectForKey:@"ItemID"];
        if (number != nil) {
            if (number.integerValue == self.itemID) {
                return notification;
            }
        }
    }
    return nil;
}

- (void) scheduleNotification {
    UILocalNotification *existingNotification = [self notificationForThisItem];
    
    if (existingNotification != nil) {
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
    
    if (self.shouldRemind && [self.dueDate compare:[[NSDate alloc] init]] != NSOrderedAscending) {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = self.dueDate;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.alertBody = self.text;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.userInfo = @{@"ItemID" : [NSNumber numberWithInteger: self.itemID]};
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}

- (void) toggleChecked {
    self.checked = !self.checked;
}

@end