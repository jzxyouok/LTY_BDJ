//
//  LTYPlacehorderTextView.m
//  01-百思不得姐
//
//  Created by AYuan on 16/5/10.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYPlacehorderTextView.h"

@implementation LTYPlacehorderTextView

//不要让自己成为自己的代理，不然，别人在外面设置代理时自己的代理会被覆盖
//而且监听占位文字的改变最好不要让控制器作为代理监听，自己内部的事情最好放在内部处理
//在内部设置通知

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        
        self.font = [UIFont systemFontOfSize:15];
        //设置通知的话，内部接受通知与外部接受通知互不影响
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    
    return self;
}

/*
 * 监听文字改变
 */
- (void)textDidChange
{
    [self setNeedsDisplay];//将会调用drawRect方法
}

/*
 * 绘制占位文字(每次调用drawRect方法之前,系统都会自动把以前画的东西擦掉)
 */
- (void)drawRect:(CGRect)rect
{
    //如果有文字，直接返回，不绘制占位文字
//    if (self.text.length || self.attributedText.length) return;
    if (self.hasText) return;
    
    rect.origin.x = 4;
    rect.origin.y = 7;
    rect.size.width -= 2 * rect.origin.x;
    
    //文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [self.placeholder drawInRect:CGRectMake(rect.origin.x, rect.origin.y, self.width, self.height) withAttributes:attrs];
}

#pragma mark - 重写setter

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}


@end
