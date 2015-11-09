//
//  AppDelegate.m
//  InfiniteCircle
//
//  Created by Zun Wang on 11/7/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import "AppDelegate.h"

#import "InfiniteCircleView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  CGRect viewRect = [UIScreen mainScreen].bounds;
  self.window = [[UIWindow alloc] initWithFrame:viewRect];
  
//  self.window.backgroundColor = [UIColor whiteColor];
  UIViewController *rootVC = [[UIViewController alloc] init];
  rootVC.view.backgroundColor = [UIColor redColor];
  
//  CGRect largeRect = bounds;
//  largeRect.size.width *= 2;
//  largeRect.size.height *= 2;
//  CGRect largeRect = (CGRect){{0, 0}, {bounds.size.width * 2, bounds.size.height * 2}};
  CGSize contentSize = {viewRect.size.width * 2, viewRect.size.height};
  
  InfiniteCircleView *leftCircleView = [[InfiniteCircleView alloc] initWithFrame:viewRect];
  
  CGRect rightCircleFrame = {{viewRect.size.width, 0}, viewRect.size};
  InfiniteCircleView *rightCircleView = [[InfiniteCircleView alloc] initWithFrame:rightCircleFrame];
  
  //scrollview
  UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:viewRect];
  [scrollView addSubview:leftCircleView];
  [scrollView addSubview:rightCircleView];
  scrollView.contentSize = contentSize;
  scrollView.pagingEnabled = YES;
  
//  [rootVC.view addSubview:circleView];
  [rootVC.view addSubview:scrollView];
  
  self.window.rootViewController = rootVC;
  
  [self.window makeKeyAndVisible];
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
