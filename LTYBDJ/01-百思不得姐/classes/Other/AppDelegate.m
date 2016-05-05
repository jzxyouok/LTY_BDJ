//
//  AppDelegate.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/4.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "AppDelegate.h"
#import "LTYTabBarController.h"
#import "LTYPushGuideView.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //第一种方式是代理监听tabBar的点击，第二种是给每个tabBarItem设置addTarget
    //设置窗口的根控制器
//    LTYTabBarController *tabBarController = [[LTYTabBarController alloc] init];
//    tabBarController.delegate = self;
    self.window.rootViewController = [[LTYTabBarController alloc] init];
    
    //显示窗口
    [self.window makeKeyAndVisible];
    
    
    //显示推送引导
    [LTYPushGuideView show];
    
    return YES;
}

#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //发出一个通知(想监听就接受通知，不向监听就不接收通知)
//    NSNotification *userInfo = @{}
//    tabBarController.selectedViewController  tabBarController有这个功能，但这个可传可不传，因为接受通知者拿到通知后就能拿到选中的tabBarController.selectedViewController
    
    //除了在这里添加通知外，还可以在tabBarItem初始化的时设置addTarget，点击时添加通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:LTYTabBarDidSelectNotification object:nil userInfo:nil];
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
