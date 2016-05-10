//
//  LTYLoginTool.h
//  01-百思不得姐
//
//  Created by AYuan on 16/5/11.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTYLoginTool : NSObject

+ (void)setUid:(NSString *)uid;
/**
 获得当前用户登录的uid
 检测是否登录 NSString: 已经登录， nil:没有登录*/
+ (NSString *)getUid;
+ (NSString *)getUid:(BOOL)showLoginController;


@end
