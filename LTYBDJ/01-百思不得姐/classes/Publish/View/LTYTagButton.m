//
//  LTYTagButton.m
//  01-百思不得姐
//
//  Created by AYuan on 16/5/28.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYTagButton.h"

@implementation LTYTagButton

/*
 * 用纯代码创建button重写initWithFrame
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundColor:LTYTabBg];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.width += 3 * LTYTargetMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = LTYTargetMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + LTYTargetMargin;
}

@end
