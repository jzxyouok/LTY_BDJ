//
//  UIView+LTYExtension.h
//  01-百思不得姐
//
//  Created by AYuan on 16/3/5.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LTYExtension)

/** 控件的size */
@property (nonatomic, assign) CGSize size;
/** 控件的width */
@property (nonatomic, assign) CGFloat width;
/** 控件的height */
@property (nonatomic, assign) CGFloat height;
/** 控件的x */
@property (nonatomic, assign) CGFloat x;
/** 控件的y */
@property (nonatomic, assign) CGFloat y;
/** 控件的centerX */
@property (nonatomic, assign) CGFloat centerX;
/** 控件的centerY */
@property (nonatomic, assign) CGFloat centerY;


/** 在分类中声明@property,只会生成方法的声明，不会生成方法的实现和带有下划线的成员变量 */


@end
