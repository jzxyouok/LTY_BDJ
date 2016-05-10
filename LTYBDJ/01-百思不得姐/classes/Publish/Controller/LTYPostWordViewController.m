//
//  LTYPostWordViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/5/7.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYPostWordViewController.h"
#import "LTYPlacehorderTextView.h"

@interface LTYPostWordViewController ()
/** 文本输入控件*/
@property (nonatomic, weak) LTYPlacehorderTextView *textView;
@end

@implementation LTYPostWordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
    
}

- (void)setupTextView
{
    LTYPlacehorderTextView *textView = [[LTYPlacehorderTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    [self.view addSubview:textView];
    self.textView = textView;
    
}

- (void)setupNav
{
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;//默认不能点击
    
    
    //强制刷新(有时候设置状态属性但不显示，可能是延迟的问题，则可以强制刷新)
    [self.navigationController.navigationBar layoutIfNeeded];
    //    下面这句不起作用，因为导航控制器与view不在一个层级上，可以拿到导航控制器的view强制刷新
    //    [self.view layoutIfNeeded];
    
    
}

- (void)post
{
    
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
