//
//  LTYUser.h
//  01-百思不得姐
//
//  Created by AYuan on 16/3/29.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTYUser : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

@end
