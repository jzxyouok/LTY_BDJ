//
//  LTYTopicVoiceView.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/29.
//  Copyright © 2016年 AYuan. All rights reserved.
//  声音帖子

#import "LTYTopicVoiceView.h"
#import "LTYTopic.h"
#import <UIImageView+WebCache.h>
#import "LTYShowPictureViewController.h"

@interface LTYTopicVoiceView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *voicePlayCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;

@end

@implementation LTYTopicVoiceView


+ (instancetype)topicVoiceView
{
    LTYTopicVoiceView *voiceView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];

    return voiceView;
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    
}

- (void)showPicture
{
    LTYShowPictureViewController *pictureVc = [[LTYShowPictureViewController alloc] init];
    
    pictureVc.topic = self.topics;
    
    //因为这是在view中所以得在UIApplication中拿到他的根控制器,并用modal出图片控制器
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pictureVc animated:YES completion:nil];
}


- (void)setTopics:(LTYTopic *)topics
{
    _topics = topics;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topics.large_image]];
    
    //播放次数
    self.voicePlayCountLabel.text = [NSString stringWithFormat:@"%zd次播放",topics.playcount];
    
    //播放时长
    NSInteger second = topics.voicetime / 60;
    NSInteger minute = second % 60;
    second = second %60;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
}

@end
