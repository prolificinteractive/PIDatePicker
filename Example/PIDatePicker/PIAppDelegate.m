//
//  PIAppDelegate.m
//  PIDatePicker
//
//  Created by CocoaPods on 03/30/2015.
//  Copyright (c) 2014 Christopher Jones. All rights reserved.
//

#import "PIAppDelegate.h"
#import "PIViewController.h"

@implementation PIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self loadWindow];
    return YES;
}

- (void)loadWindow
{
    UIWindow *rootWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    rootWindow.rootViewController = [[PIViewController alloc] init];
    self.window = rootWindow;

    [self.window makeKeyAndVisible];
}

@end
