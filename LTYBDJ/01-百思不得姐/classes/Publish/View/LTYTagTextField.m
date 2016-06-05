
//
//  LTYTagTextField.m
//  01-百思不得姐
//
//  Created by AYuan on 16/6/5.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYTagTextField.h"

@implementation LTYTagTextField

//也能在下面这个方法中监听键盘的输入
//我也不清楚为什么重写系统的代理方法不会调用下面这个方法
//- (void)insertText:(NSString *)text
//{
//    [super insertText:text];
//    //判断是否为换行，是的话将这个事件抛给外面的控制器
//    [text isEqualToString:@"\n"];
//    
//    
//}

- (void)deleteBackward
{
    !self.deleteBlock ? : self.deleteBlock();
    [super deleteBackward];

    LTYLogFunc;
}



@end
