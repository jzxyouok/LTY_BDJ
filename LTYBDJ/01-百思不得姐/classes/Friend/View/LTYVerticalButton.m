//
//  LTYVerticalButton.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/13.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYVerticalButton.h"

@implementation LTYVerticalButton

/**
只需要算一次的初始化代码
 以后不管是通过xib／sb中创建或者代码创建，在awakeFromNib和initWithFrame调用就好
 */
- (void)setup
{
    self.titleLabel.textAlignment =NSTextAlignmentCenter;
}

- (void)awakeFromNib
{
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y ;
    
}


@end
