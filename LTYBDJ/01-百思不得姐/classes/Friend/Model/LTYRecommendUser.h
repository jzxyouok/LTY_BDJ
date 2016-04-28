//
//  LTYRecommendUser.h
//  01-百思不得姐
//
//  Created by AYuan on 16/3/10.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTYRecommendUser : NSObject

/** 头像 */
@property (nonatomic, copy) NSString *header;
/** 粉丝数 */
@property (nonatomic, assign) NSInteger fans_count;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;

@end
