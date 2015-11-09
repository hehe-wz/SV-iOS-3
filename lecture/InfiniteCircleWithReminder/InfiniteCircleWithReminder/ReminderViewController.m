//
//  ReminderViewController.m
//  InfiniteCircleWithReminder
//
//  Created by Zun Wang on 11/8/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import "ReminderViewController.h"

@interface ReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation ReminderViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    //init config
    self.tabBarItem.title = @"Reminder";
  }
  return self;
}

- (void)viewDidLoad {
  NSLog(@"Reminder VC loaded.");
}

- (void)viewWillAppear:(BOOL)animated {
  NSLog(@"Reminder VC will appear.");
}

- (void)viewDidAppear:(BOOL)animated {
  NSLog(@"Reminder VC appeared.");
}

- (void)viewWillDisappear:(BOOL)animated {
  NSLog(@"Reminder VC will disappear");
}

- (IBAction)userTapRemindButton:(id)sender {
  
}

@end
