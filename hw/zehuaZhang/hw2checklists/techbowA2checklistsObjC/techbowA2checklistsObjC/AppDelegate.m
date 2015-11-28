//
//  AppDelegate.m
//  techbowA2checklistsObjC
//
//  Created by ZhangZehua on 11/20/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - initialize

- (instancetype)init
{
    self = [super init];
    
    NSLog(@"AppDelegate init Called");
    
    if (self) {
        _dataModel = [[DataModel alloc] init];
    }
    return self;
}

#pragma mark - other

- (void) saveData {
    [_dataModel saveChecklists];
}

#pragma mark - appDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UINavigationController *navigationController = (UINavigationController *)_window.rootViewController;
    AllListsViewController *controller = (AllListsViewController *)navigationController.viewControllers[0];
    
    controller.dataModel = _dataModel;
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self saveData];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveData];
}

@end
