//
//  LTYTopicPictureView.h
//  01-百思不得姐
//
//  Created by AYuan on 16/3/19.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTYTopic;
@interface LTYTopicPictureView : UIView

+ (instancetype)topicPictureView;
/** 模型数据 */
@property (nonatomic, strong) LTYTopic *topics;



@end
