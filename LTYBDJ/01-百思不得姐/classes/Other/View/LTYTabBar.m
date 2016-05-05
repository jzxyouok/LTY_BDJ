//
//  LTYTabBar.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/4.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYTabBar.h"
#import "LTYPublishView.h"

@interface LTYTabBar()

@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation LTYTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置tabbar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        //添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

//UIWindow *window;

- (void)publishClick
{
//    LTYPublishView *publishView = [LTYPublishView publishView];
//    UIWindow *keyWindow =  [UIApplication sharedApplication].keyWindow;
//    publishView.frame = keyWindow.bounds; 
//    [keyWindow addSubview:publishView];
    
    //窗口级别
//    UIWindowLevelNormal < UIWindowLevelStatusBar < UIWindowLevelAlert
    
    //如果想在上面（状态栏那块跳出东西提醒用户)则搞个比状态栏优先级高的window就可以盖住状态栏,在window上面加些东西就可以了
    
    
    //如果是创建窗口的话，则该窗口与其他窗口就无关，点击事件也不会传到其他窗口的控制器
//    window = [[UIWindow alloc] init];
//    window.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
//    window.frame = [UIScreen mainScreen].bounds;
//    window.hidden = NO;
    
    [LTYPublishView show];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //标记按钮是否已经添加过监听器
    static BOOL added = NO;
    
    //设置发布按钮的frame
    CGFloat width = self.width;
    CGFloat height = self.height;
    self.publishButton.width = self.publishButton.currentBackgroundImage.size.width;
    self.publishButton.height = self.publishButton.currentBackgroundImage.size.height;
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    //设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIControl *button in self.subviews) {
//        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        //计算按钮的x值
        CGFloat buttonX = buttonW * ((index >1) ? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //增加索引
        index++;
        
        if (added == NO) {
            //监听按钮点击
            //addTarget方法是UIControl中的
            [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
        added = YES;
        
    }
}

- (void)buttonClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LTYTabBarDidSelectNotification object:nil userInfo:nil];
}

@end
