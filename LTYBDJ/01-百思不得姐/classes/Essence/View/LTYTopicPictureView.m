//
//  LTYTopPictureView.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/19.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "LTYTopic.h"
#import "LTYProgressView.h"
#import "LTYShowPictureViewController.h"

@interface LTYTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPicture;
@property (weak, nonatomic) IBOutlet UIImageView *gifImage;
@property (weak, nonatomic) IBOutlet LTYProgressView *progressView;



@end

@implementation LTYTopicPictureView

+ (instancetype)topicPictureView
{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //给图片添加监听器
    self.pictureView.userInteractionEnabled = YES;
    [self.pictureView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];

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
    
    //立马显示更新的进度值(防止因为网速慢，导致显示的是其他图片的下载进度(cell的循环利用))
    [self.progressView setProgress:topics.pictureProgress animated:NO];
    
    //设置图片(在此处加载图片时创建的operation在将来点击图片查看大图时的operation是同一个，所以不会出现显示进度不同的问题，但是有时候会出现是因为网络的时延导致那个block没有及时调用)
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:topics.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //progress的block会调很多次，completed的block在加载完之后调用一次,由于cell的循环利用，所以在这里要先把progressView搞出来
        self.progressView.hidden = NO;
        //计算进度值
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        //显示进度值
        [self.progressView setProgress:progress animated:NO];
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        
        if (!topics.isBigPicture) return;
        
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topics.pictureF.size, YES, 0.0);
        
        //将下载完的image对象绘制到图形上下文
        CGFloat width = topics.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        //获得图片(下载完毕后将图片传过来将新绘制的合适尺寸的图片赋给pictureView)
        self.pictureView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        //结束图形上下文
        UIGraphicsEndImageContext();
        
        
    }];
    
    //判断是否为gif
    NSString *extension = topics.large_image.pathExtension;
    self.gifImage.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
//    self.seeBigPicture.hidden = !topics.isBigPicture;
    
    //判断是否显示"点击查看全图"
    if (topics.isBigPicture) { //大图
        self.seeBigPicture.hidden = NO;
        
    } else { //非大图
        self.seeBigPicture.hidden = YES;
        self.pictureView.contentMode = UIViewContentModeScaleToFill;
    }
    
}



@end




















