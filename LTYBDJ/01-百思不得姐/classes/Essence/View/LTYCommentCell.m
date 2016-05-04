//
//  LTYCommentCell.m
//  01-百思不得姐
//
//  Created by AYuan on 16/4/5.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYCommentCell.h"
#import <UIImageView+WebCache.h>
#import "LTYComment.h"
#import "LTYUser.h"

@interface LTYCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end

@implementation LTYCommentCell

- (void)setComment:(LTYComment *)comment
{
    _comment = comment;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sexView.image = [comment.user.sex isEqualToString:LTYUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    self.contentLabel.text = comment.content;
    
}

//背景
- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}


- (void)setFrame:(CGRect)frame
{
    frame.origin.x = LTYTopicCellMargin;
    frame.size.width -= 2 * LTYTopicCellMargin;
    
    [super setFrame:frame];
}

#pragma mark - MenuComtroller处理
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

@end
