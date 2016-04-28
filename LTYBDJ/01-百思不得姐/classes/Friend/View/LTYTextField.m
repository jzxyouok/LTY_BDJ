//
//  LTYTextField.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/14.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYTextField.h"
#import <objc/runtime.h>

@implementation LTYTextField


+ (void)initialize
{
    [self getIvars];
}

+ (void)getProperty
{
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
    
    for (int i = 0; i < count; i++) {
        //取出属性
        objc_property_t property = properties[i];
        
        //打印属性名字
//        LTYLog(@"%s <--------->%s",property_getName(property),property_getAttributes(property));
    }
    
    free(properties);

}

+ (void)getIvars
{
    //返回属性的数量
    unsigned int count = 0;
    
    //拷贝出所有的成员变量列表
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (int i = 0;i < count; i++)
    {
        //取出成员变量
        Ivar ivar = *(ivars + 1);
        
        //打印成员变量的名字
//        LTYLog(@"%s",ivar_getTypeEncoding(ivar));
    }
    
    //释放 (自己拷贝的对象自己要负责释放掉)
    free(ivars);

}

- (void)awakeFromNib
{
//    UILabel *placeholderLabel = [self valueForKey:@"_placeholderLabel"];
//    placeholderLabel.textColor = [UIColor redColor];
    
//    //修改占位文字颜色
//    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //设置光标颜色和文字颜色一致
    //一般光标颜色、导航颜色、渐变颜色等都是tintColor
    self.tintColor = self.textColor;
    [self resignFirstResponder];
    
}

/**
 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder
{
    //修改占位文字颜色
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    
    return [super becomeFirstResponder];
}

/**
 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder
{
    //修改占位文字颜色
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    return [super resignFirstResponder];
}



@end
