//
//  LTYAddTargetTool.m
//  01-百思不得姐
//
//  Created by AYuan on 16/5/21.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYAddTargetTool.h"
#import "LTYAddTargetViewController.h"

@interface LTYAddTargetTool()

@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation LTYAddTargetTool

- (void)awakeFromNib
{
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addBtn.size = addBtn.currentImage.size;
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:addBtn];
    
}

- (void)addBtnClick
{
    LTYAddTargetViewController *addTargetVC = [[LTYAddTargetViewController alloc] init];
    
    UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *preVc = (UINavigationController *)rootVc.presentedViewController;
    [preVc pushViewController:addTargetVC animated:YES];
    
}

@end
