//
//  LTYNewViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/4.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYNewViewController.h"

@interface LTYNewViewController ()

@end

@implementation LTYNewViewController

- (void)viewDidLoad {
    
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(newClick)];
    
    //设置背景色
    self.view.backgroundColor = LTYGlobalBg;
}

- (void)newClick
{
    LTYLogFunc;
}



@end
