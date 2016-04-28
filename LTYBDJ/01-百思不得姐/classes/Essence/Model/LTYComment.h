//
//  LTYComment.h
//  01-百思不得姐
//
//  Created by AYuan on 16/3/29.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LTYUser;
@interface LTYComment : NSObject

/** 评论id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voiceTime;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) LTYUser *user;

@end
