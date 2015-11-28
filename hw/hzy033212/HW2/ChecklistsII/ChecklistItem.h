//
//  ChecklistItem.h
//  ChecklistsII
//
//  Created by Eric Huang on 11/17/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject <NSCoding>
@property (nonatomic) NSString *text;
@property (nonatomic) bool checked;
@property (nonatomic) NSDate *dueDate;
@property (nonatomic) bool shouldRemind;
@property (nonatomic) NSInteger itemID;
-(instancetype)init;
-(instancetype)initWithText: (NSString *)text andWithChecked: (bool)checked;
-(void)toggleChecked;
-(void)encodeWithCoder:(NSCoder *)aCoder;
-(instancetype)initWithCoder:(NSCoder *)aDecoder;
-(void)scheduleNotification;
-(void)dealloc;
@end
