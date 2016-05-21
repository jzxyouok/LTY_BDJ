//
//  LTYLoginTool.m
//  01-百思不得姐
//
//  Created by AYuan on 16/5/11.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYLoginTool.h"
#import "LTYLoginRegisterViewController.h"

@implementation LTYLoginTool

+ (void)setUid:(NSString *)uid
{
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"uid"];
    //马上同步进去
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getUid
{
//    NSString *uid = [[NSUserDefaults standardUserDefaults] stringForKey:@"uid"];
//    
//    LTYLoginRegisterViewController *login = [[LTYLoginRegisterViewController alloc] init];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
//    return uid;
    
    return [self getUid:NO];
}

/**
 如果马上想登录的话 传yes进来
 */
+ (NSString *)getUid:(BOOL)showLoginController
{
    NSString *uid = [[NSUserDefaults standardUserDefaults] stringForKey:@"uid"];

    if (showLoginController) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LTYLoginRegisterViewController *login = [[LTYLoginRegisterViewController alloc] init];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
        });
    }
    return uid;
}

@end









