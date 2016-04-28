//
//  LTYShowPictureViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/20.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYShowPictureViewController.h"
#import "LTYTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "LTYProgressView.h"

@interface LTYShowPictureViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet LTYProgressView *progressView;


@end

@implementation LTYShowPictureViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //屏幕尺寸
    //从xib加载出来的控制器的view与屏幕尺寸不一样，所以这里直接拿mainScreen的宽度
    CGFloat screenH = LTYScreenH;
    CGFloat screenW = LTYScreenW;
    
    //添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    
    //图片尺寸
    CGFloat pictureW = screenW;
    CGFloat pictureH = self.topic.height * pictureW / self.topic.width;
    if (pictureH > screenH) {  //图片显示高度超过一个屏幕，需要滚动查看
        
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
        
    } else {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH * 0.5;
    }

    //马上显示当前图片的下载进度
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    //设置图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        
        //这块只modal出一张图片不会牵扯到循环利用，所以不用在前面设置progressView的hidden属性为no，animated也可以为yes
        [self.progressView setProgress:progress animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
        self.progressView.hidden = YES;
    }];
    
}



- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)save {
    //将图片写入相册
  
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片未下载完毕"];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}



@end
