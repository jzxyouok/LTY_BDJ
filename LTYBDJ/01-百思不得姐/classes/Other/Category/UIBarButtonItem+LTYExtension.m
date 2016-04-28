//
//  UIBarButtonItem+LTYExtension.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/5.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "UIBarButtonItem+LTYExtension.h"

@implementation UIBarButtonItem (LTYExtension)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

@end
