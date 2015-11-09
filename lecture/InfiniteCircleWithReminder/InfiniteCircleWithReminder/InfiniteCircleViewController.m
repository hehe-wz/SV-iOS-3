//
//  InfiniteCircleViewController.m
//  InfiniteCircleWithReminder
//
//  Created by Zun Wang on 11/8/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import "InfiniteCircleViewController.h"

#import "InfiniteCircleView.h"

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
}

@end
