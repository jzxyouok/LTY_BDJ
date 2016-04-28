//
//  LTYLoginRegisterViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/13.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYLoginRegisterViewController.h"

@interface LTYLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
/**
 登录框距离控制器view左边的间距
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation LTYLoginRegisterViewController
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)showLoginOrRegister:(UIButton *)button {
    
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) { //显示注册界面
        self.loginViewLeftMargin.constant = - self.view.width;
        button.selected = YES;
//        [button setTitle:@"已有账号？" forState:UIControlStateNormal];
    } else { //显示登录界面
        self.loginViewLeftMargin.constant = 0;
        button.selected = NO;
//        [button setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.25 animations:^{
        //马上更新布局
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 让当前控制器的状态栏为白色
 iOS7之前状态栏是交给Application管的，之后交给控制器更改状态栏样式
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
