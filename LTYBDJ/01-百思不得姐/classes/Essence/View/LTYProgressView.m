//
//  LTYProgressView.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/20.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYProgressView.h"

@implementation LTYProgressView

- (void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}


@end
