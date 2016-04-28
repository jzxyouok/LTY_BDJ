//
//  LTYTopicCell.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/16.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYTopicCell.h"
#import "LTYTopic.h"
#import <UIImageView+WebCache.h>
#import "LTYTopicPictureView.h"
#import "LTYTopicVoiceView.h"
#import "LTYTopicVideoView.h"
#import "LTYComment.h"
#import "LTYUser.h"

@interface LTYTopicCell()

/**  头像*/
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/**  名称*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**  时间*/
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/**  顶*/
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/**  踩*/
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/**  分享*/
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/**  评论*/
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/**  新浪加v*/
@property (weak, nonatomic) IBOutlet UIButton *sinaVView;
/** 帖子内容*/
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
/** 帖子图片*/
@property (nonatomic, weak) LTYTopicPictureView *pictureView;
/** 帖子声音*/
@property (nonatomic, weak) LTYTopicVoiceView *voiceView;
/** 帖子音频*/
@property (nonatomic, weak) LTYTopicVideoView *videoView;
/** 最热评论内容*/
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/** 最热评论整体*/
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@end

@implementation LTYTopicCell

+ (instancetype)topicCell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (LTYTopicPictureView *)pictureView
{
    if (_pictureView == nil) {
        LTYTopicPictureView *pictureView = [LTYTopicPictureView topicPictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
        
    }
    return _pictureView;
}

- (LTYTopicVideoView *)videoView
{
    if (_videoView == nil) {
        LTYTopicVideoView *videoView = [LTYTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
        
    }
    return _videoView;
}

- (LTYTopicVoiceView *)voiceView
{
    if (_voiceView == nil) {
        LTYTopicVoiceView *voiceView = [LTYTopicVoiceView topicVoiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
        
    }
    return _voiceView;
}


//背景
- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopics:(LTYTopic *)topics
{
   
    _topics = topics;
    
    // 设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topics.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    // 设置名字
    self.nameLabel.text = topics.name;
    
    // 设置帖子的创建时间
    self.createTimeLabel.text = topics.create_time;
    
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topics.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topics.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topics.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topics.comment placeholder:@"评论"];
    
    self.sinaVView.hidden = !topics.isSina_v;
    
    //设置帖子文字内容
    self.topicLabel.text = topics.text;
    
    //根据模型类型(帖子类型)添加对应的内容到cell中间
    if (topics.type == LTYTopicTypePicture) { //图片帖子
        self.pictureView.hidden = NO; //又YES就有NO,这是循环利用的原则
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.topics = topics;
        self.pictureView.frame = topics.pictureF;
    } else if (topics.type == LTYTopicTypeVoice) { //声音帖子
        self.pictureView.hidden = YES;
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.topics = topics;
        self.voiceView.frame = topics.voiceF;
    } else if (topics.type == LTYTopicTypeVideo) {  //音频帖子
        
        self.videoView.topic = topics;
        self.videoView.frame = topics.videoF;
    } else { //段子帖子
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        
    }
    
    //处理最热评论
    LTYComment *cmt = topics.top_cmt;
    if (cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@:%@",cmt.user.username,cmt.content];
    } else {
        self.topCmtView.hidden = YES;
        
    }
    
}

- (void)testDate:(NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // 当前时间
    NSDate *now = [NSDate date];
    // 发帖时间
    NSDate *create = [fmt dateFromString:create_time];
    
    LTYLog(@"%@", [now deltaFrom:create]);
    
}


/**
 * 设置底部按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}


- (void)setFrame:(CGRect)frame
{
    
    frame.origin.x = LTYTopicCellMargin;
    frame.size.width -= 2 * frame.origin.x;
//    frame.size.height -= LTYTopicCellMargin;
    frame.size.height = self.topics.cellHeight - LTYTopicCellMargin;
    frame.origin.y += LTYTopicCellMargin;
    
    [super setFrame:frame];
}
//
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

- (IBAction)more {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
    [sheet showInView:self.window];
    
}





@end
