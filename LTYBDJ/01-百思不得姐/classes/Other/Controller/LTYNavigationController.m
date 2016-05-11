//
//  LTYNavigationController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/7.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYNavigationController.h"

@implementation LTYNavigationController

/**
 当第一次使用这个类的时候会调用一次
 appearance的一次性设置
 */
+ (void)initialize
{
    //用appearance后，以后无论是LTYNavigationController还是系统的导航栏背景图片都会被设置
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
    //设置item
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //UIControlStateNormal
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    //UIControlStateDisabled
    NSMutableDictionary *itemDisableAttrs = [NSMutableDictionary dictionary];
    itemDisableAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    itemDisableAttrs[NSFontAttributeName] = itemAttrs[NSFontAttributeName];
    [item setTitleTextAttributes:itemDisableAttrs forState:UIControlStateDisabled];
    
    //下面这种方法只在设定的类(LTYNavigationController)的导航栏才会生效
//    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
//    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //如果滑动移除控制器的功能失效，清空代理(让导航控制器重新设置这个功能)
    //如果不是用系统的导航栏左边的item，则滑动移除控制器的功能失效
    self.interactivePopGestureRecognizer.delegate = nil;
    
    
    
}

/**
 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
//    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];

    if (self.childViewControllers.count > 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//        [button setBackgroundColor:[UIColor blueColor]];
        //让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //让按钮的尺寸与内部内容相合适
//        [button sizeToFit];
        //让按钮内部的内容左多切出10个间距出来
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        //点击返回按钮返回到上一个控制器
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        //隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //这句super的push要放在后面，让viewController可以覆盖上面设置的leftBarButtonItem
    //因为push进去控制器则就会加载控制器的view，此时如果另外设置leftBarButtonItem，优先级比较高会覆盖上面提前设置的东西
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}










@end
