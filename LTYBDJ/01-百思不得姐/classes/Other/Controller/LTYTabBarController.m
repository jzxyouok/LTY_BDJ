//
//  LTYTabBarController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/4.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYTabBarController.h"
#import "LTYEssenceViewController.h"
#import "LTYNewViewController.h"
#import "LTYFriendViewController.h"
#import "LTYMeViewController.h"
#import "LTYTabBar.h"
#import "LTYNavigationController.h"

@interface LTYTabBarController ()

@end

@implementation LTYTabBarController

+ (void)initialize
{

    //*****凡是方法声明后面有 UI_APPEARANCE_SELECTOR的，都可以通过appearance统一设置
    //通过appearance统一设置所有UITabBarItem的文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selAttrs = [NSMutableDictionary dictionary];
    selAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selAttrs forState:UIControlStateHighlighted];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self setupChildViewController:[[LTYEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupChildViewController:[[LTYNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupChildViewController:[[LTYFriendViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildViewController:[[LTYMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
//    [self.tabBar addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    
    //更换tabBar
    //属性为readonly时set方法不能设置时用kvc，kvc直接访问下划线成员变量
//    self.tabBar = [[LTYTabBar alloc] init];
    [self setValue:[[LTYTabBar alloc] init] forKey:@"tabBar"];
    //既然是自定义tabBar，则内部的设置细节就不要写在这了，写在自己定义的的tabBar中
//    self.tabBar setBackgroundImage:<#(UIImage * _Nullable)#>
    
    
}

/**
 初始化子控制器
 */
- (void)setupChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //设置文字和图片
    //设置背景颜色不要放在这，否则一开始就会创建控制器的view，一创建控制器的view可能就会向服务器发送数据,所以设置背景颜色要放在各自控制器的view中
//    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    LTYNavigationController *nav = [[LTYNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}


@end
