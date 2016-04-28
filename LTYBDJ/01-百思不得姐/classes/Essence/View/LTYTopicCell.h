//
//  LTYTopicCell.h
//  01-百思不得姐
//
//  Created by AYuan on 16/3/16.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTYTopic;
@interface LTYTopicCell : UITableViewCell

+ (instancetype)topicCell;

/** 模型数据 */
@property (nonatomic, strong) LTYTopic *topics;
///**  头像*/
//@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
///**  名称*/
//@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
///**  时间*/
//@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
///**  顶*/
//@property (weak, nonatomic) IBOutlet UIButton *dingButton;
///**  踩*/
//@property (weak, nonatomic) IBOutlet UIButton *caiButton;
///**  分享*/
//@property (weak, nonatomic) IBOutlet UIButton *shareButton;
///**  评论*/
//@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end
