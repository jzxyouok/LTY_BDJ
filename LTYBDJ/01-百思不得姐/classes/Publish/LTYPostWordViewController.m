//
//  LTYPostWordViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/5/7.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYPostWordViewController.h"

@interface LTYPostWordViewController ()

@end

@implementation LTYPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    
    
    
}

- (void)post
{
    
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
