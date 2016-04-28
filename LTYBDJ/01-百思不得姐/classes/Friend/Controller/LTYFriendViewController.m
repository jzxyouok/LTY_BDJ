//
//  LTYFriendViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/4.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYFriendViewController.h"
#import "LTYRecommendViewController.h"
#import "LTYLoginRegisterViewController.h"

@interface LTYFriendViewController ()

@end

@implementation LTYFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
        
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendClick)];
    
    //设置背景色
    self.view.backgroundColor = LTYGlobalBg;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)friendClick
{
    LTYRecommendViewController *vc = [[LTYRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginRegister:(id)sender {
    
    //只要是alloc init出来的控制器会自动从加载通明的xib文件
    LTYLoginRegisterViewController *login = [[LTYLoginRegisterViewController alloc] init];
    [self presentModalViewController:login animated:YES];
}




















@end
