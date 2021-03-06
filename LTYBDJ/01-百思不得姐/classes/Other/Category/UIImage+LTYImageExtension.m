//
//  UIImage+LTYImageExtension.m
//  01-百思不得姐
//
//  Created by AYuan on 16/5/4.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "UIImage+LTYImageExtension.h"

@implementation UIImage (LTYImageExtension)

- (UIImage *)circleImage
{
    //开启上下文,NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    //获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    //裁剪
    CGContextClip(ctx);
    
    //将图片画上去
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
