//
//  LTYTopic.h
//  01-百思不得姐
//
//  Created by AYuan on 16/3/16.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTYComment;
@interface LTYTopic : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 是否为新浪加V用户 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 服务器返回的key为image0,小图 */
@property (nonatomic, copy) NSString *small_image;
/** 中图的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图的URL */
@property (nonatomic, copy) NSString *large_image;
/** 帖子的类型 */
@property (nonatomic, assign) LTYTopicType type;
/** 音频时长*/
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长*/
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数*/
@property (nonatomic, assign) NSInteger playcount;
/** 最热评论 */
@property (nonatomic, strong) LTYComment *top_cmt;
/** 状态 */
@property (nonatomic, copy) NSString *status;

/** 额外的辅助属性 */
/** cell的高度 */
//readonly会帮我们生成getter方法以及下划线成员变量
//如果当你重写getter方法时，下划线成员变量就没有了
@property (nonatomic, assign, readonly) CGFloat cellHeight;

/** 图片的frame */
@property (nonatomic, assign) CGRect pictureF;
/** 大图 */
@property (nonatomic, assign,getter=isBigPicture) BOOL bigPicture;
/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;

/** 声音图片的frame */
@property (nonatomic, assign) CGRect voiceF;

/** 音频图片的frame */
@property (nonatomic, assign) CGRect videoF;





@end







