//
//  AppDelegate.m
//  ChecklistsII
//
//  Created by Eric Huang on 11/16/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import "AppDelegate.h"
#import "AllListsViewController.h"
#import "DataModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)saveData {
  [self.dataModel saveChecklists];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
  AllListsViewController *controller = (AllListsViewController *)navigationController.viewControllers[0];
  if (self.dataModel == nil) {
    self.dataModel = [[DataModel alloc] init];
  }
  controller.dataModel = self.dataModel;
  
//  [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
//  
//  UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//  localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:10];
//  localNotification.timeZone = [NSTimeZone defaultTimeZone];
//  localNotification.alertBody = @"I am a local notification";
//  localNotification.soundName = UILocalNotificationDefaultSoundName;
//  [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
  
  return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  [self saveData];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  [self saveData];
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
  NSLog(@"didReceieveLocalNotification %@", notification);
}

@end
