//
//  LTYCommentCell.h
//  01-百思不得姐
//
//  Created by AYuan on 16/4/5.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTYComment;

@interface LTYCommentCell : UITableViewCell

/** 评论模型 */
@property (nonatomic, strong) LTYComment *comment;

@end
