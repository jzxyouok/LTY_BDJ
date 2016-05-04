//
//  UIImageView+LTYExtension.m
//  01-百思不得姐
//
//  Created by AYuan on 16/5/4.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "UIImageView+LTYExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (LTYExtension)

- (void)setCircleHeader:(NSString *)header
{
    // 设置头像
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:header] placeholderImage:[[UIImage imageNamed:@"defaultUserIcon"] circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];

}

@end
