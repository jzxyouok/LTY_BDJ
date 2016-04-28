//
//  LTYTopicVideoView.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/29.
//  Copyright © 2016年 AYuan. All rights reserved.
//  视频帖子

#import "LTYTopicVideoView.h"
#import <UIImageView+WebCache.h>
#import "LTYTopic.h"
#import "LTYShowPictureViewController.h"

@interface LTYTopicVideoView()

@property (weak, nonatomic) IBOutlet UILabel *palyCount;
@property (weak, nonatomic) IBOutlet UILabel *videoTime;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation LTYTopicVideoView

+ (instancetype)videoView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
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
    
    pictureVc.topic = self.topic;
    
    //因为这是在view中所以得在UIApplication中拿到他的根控制器,并用modal出图片控制器
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pictureVc animated:YES completion:nil];
}


- (void)setTopic:(LTYTopic *)topic
{
    _topic = topic;
    
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    //播放次数
    self.palyCount.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    
    //播放时长
    NSInteger second = topic.videotime / 60;
    NSInteger minute = second % 60;
    second = second %60;
    self.videoTime.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
}




@end














