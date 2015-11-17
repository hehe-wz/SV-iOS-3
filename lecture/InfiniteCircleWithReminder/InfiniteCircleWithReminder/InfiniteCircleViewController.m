//
//  InfiniteCircleViewController.m
//  InfiniteCircleWithReminder
//
//  Created by Zun Wang on 11/8/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import "InfiniteCircleViewController.h"

#import "InfiniteCircleView.h"

@interface InfiniteCircleViewController () <UITextFieldDelegate>
@end

@implementation InfiniteCircleViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    //init config
    self.tabBarItem.title = @"Circle";
  }
  return self;
}

- (void)loadView {
  self.view = [[InfiniteCircleView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  
  UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 70, 240, 30)];
  textField.borderStyle = UITextBorderStyleRoundedRect;
  textField.placeholder = @"Please type something";
  textField.keyboardType = UIKeyboardTypeEmailAddress;
  textField.returnKeyType = UIReturnKeyDone;
  textField.delegate = self;
  
  [self.view addSubview:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

@end
