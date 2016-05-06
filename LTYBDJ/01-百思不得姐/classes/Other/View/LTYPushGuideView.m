//
//  LTYPushGuideView.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/15.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYPushGuideView.h"

@implementation LTYPushGuideView

+ (void)show
{
    //    LTYLog(@"%@",[NSBundle mainBundle].infoDictionary);
    
    NSString *key = @"CFBundleShortVersionString";
    
    //先从info.plist文件中取出当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //再从沙盒中取出上次的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        LTYPushGuideView *guideView = [LTYPushGuideView guide];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
    }
    
    //存储版本号
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
    //调用synchronize马上存储
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (instancetype)guide
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)cancel {
    [self removeFromSuperview];
}

@end
