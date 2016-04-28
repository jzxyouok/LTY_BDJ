//
//  LTYMeViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/4.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYMeViewController.h"

@interface LTYMeViewController ()

@end

@implementation LTYMeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    //设置导航栏右边的按钮
    UIBarButtonItem *settingButton =[UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonButton =[UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];

    self.navigationItem.rightBarButtonItems = @[
                            settingButton,
                            moonButton
                                                ];
    
    //设置背景色
    self.view.backgroundColor = LTYGlobalBg;
}

- (void)moonClick
{
    LTYLogFunc;
}


- (void)settingClick
{
    LTYLogFunc;
}

@end
