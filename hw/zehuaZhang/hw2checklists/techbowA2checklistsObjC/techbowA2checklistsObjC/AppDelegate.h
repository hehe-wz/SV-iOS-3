//
//  AppDelegate.h
//  techbowA2checklistsObjC
//
//  Created by ZhangZehua on 11/20/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "AllListsViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) DataModel* dataModel;

@end

