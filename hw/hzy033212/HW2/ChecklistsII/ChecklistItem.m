//
//  ChecklistItem.m
//  ChecklistsII
//
//  Created by Eric Huang on 11/17/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import "ChecklistItem.h"
#import "DataModel.h"
#import <UIKit/UIKit.h>

@implementation ChecklistItem

#pragma mark - init methods

-(instancetype)init{
  self = [super init];
  if (self) {
    self.itemID = [DataModel nextChecklistItemID];
    self.text = @"";
    self.checked = NO;
  }
  return self;
}

-(instancetype)initWithText: (NSString *)text andWithChecked: (bool)checked {
  self = [super init];
  if (self) {
    self.text = text;
    self.checked = checked;
  }
  return self;
}

-(void)dealloc {
  UILocalNotification *existingNotification = [self notificationForThisItem];
  NSLog(@"Removing existing notification %@", existingNotification);
  [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
}

#pragma mark - functional methods

-(void)toggleChecked{
  self.checked = !self.checked;
}

#pragma mark - encode and decode methods

-(void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.text forKey:@"Text"];
  [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
  [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
  [aCoder encodeInteger:self.itemID forKey:@"ItemID"];
  [aCoder encodeBool:self.checked forKey:@"Checked"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
  self.text = [aDecoder decodeObjectForKey:@"Text"];
  self.dueDate = (NSDate *)[aDecoder decodeObjectForKey:@"DueDate"];
  self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
  self.itemID = [aDecoder decodeIntegerForKey:@"ItemID"];
  self.checked = [aDecoder decodeBoolForKey:@"Checked"];
  self = [super init];
  return self;
}

-(void)scheduleNotification {
  UILocalNotification *existingNotification = [self notificationForThisItem];
  NSLog(@"Found an existing notification %@", existingNotification);
  [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
  
  NSDate *date = [[NSDate alloc] init];
  if (self.shouldRemind && [self.dueDate compare:date] != NSOrderedAscending) {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = self.dueDate;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = self.text;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.userInfo = @{@"ItemID": [NSNumber numberWithInt:self.itemID]};
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    NSLog(@"Schedule local notification for %@ of %ld", localNotification, (long)self.itemID);
  }
}

-(UILocalNotification *) notificationForThisItem {
  NSArray *allNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
  for (UILocalNotification *notification in allNotifications) {
    NSNumber *number = notification.userInfo[@"ItemID"];
    if (number.integerValue == self.itemID) {
      return notification;
    }
  }
  return nil;
}

@end
