//
//  LTYTagTextField.h
//  01-百思不得姐
//
//  Created by AYuan on 16/6/5.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTYTagTextField : UITextField

/** 点击删除键后的回调*/
@property (nonatomic, copy) void (^deleteBlock)() ;

@end
