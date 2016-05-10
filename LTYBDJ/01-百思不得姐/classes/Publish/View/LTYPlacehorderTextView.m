//
//  LTYPlacehorderTextView.m
//  01-百思不得姐
//
//  Created by AYuan on 16/5/10.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYPlacehorderTextView.h"

@interface LTYPlacehorderTextView()

/** 占位文字label*/
@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation LTYPlacehorderTextView

- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 4;
        placeholderLabel.y = 7;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
        
    }
    return _placeholderLabel;
}

//不要让自己成为自己的代理，不然，别人在外面设置代理时自己的代理会被覆盖
//而且监听占位文字的改变最好不要让控制器作为代理监听，自己内部的事情最好放在内部处理
//在内部设置通知

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        // 默认的占位文字颜色
        self.placeholderColor = [UIColor grayColor];
        //默认字体
        self.font = [UIFont systemFontOfSize:15];
        //监听文字改变
        //设置通知的话，内部接受通知与外部接受通知互不影响
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
 * 监听文字改变
 */
- (void)textDidChange
{
    //只要有文字，就隐藏占位文字label
    self.placeholderLabel.hidden = self.hasText;
}

//这也是一种方法，把占位文字画上去，不过笔者推荐使用UILabel做占位文字
/*
 * 绘制占位文字(每次调用drawRect方法之前,系统都会自动把以前画的东西擦掉)
 */
//- (void)drawRect:(CGRect)rect
//{
//    //如果有文字，直接返回，不绘制占位文字
////    if (self.text.length || self.attributedText.length) return;
//    if (self.hasText) return;
//    
//    rect.origin.x = 4;
//    rect.origin.y = 7;
//    rect.size.width -= 2 * rect.origin.x;
//    
//    //文字属性
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = self.font;
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    [self.placeholder drawInRect:CGRectMake(rect.origin.x, rect.origin.y, self.width, self.height) withAttributes:attrs];
//}

/**
 * 更新占位文字的尺寸
 */

- (void)updatePlaceholderLabelSize
{
    CGSize maxSize = CGSizeMake(LTYScreenW - 2 * self.placeholderLabel.x, MAXFLOAT);
    self.placeholderLabel.size = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;

}

#pragma mark - 重写setter

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;

    [self updatePlaceholderLabelSize];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderColor  = placeholderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    [self updatePlaceholderLabelSize];
    
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}


@end
