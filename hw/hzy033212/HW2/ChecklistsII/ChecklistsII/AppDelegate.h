//
//  AppDelegate.h
//  ChecklistsII
//
//  Created by Eric Huang on 11/16/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllListsViewController.h"
#import "DataModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) DataModel *dataModel;

@end

