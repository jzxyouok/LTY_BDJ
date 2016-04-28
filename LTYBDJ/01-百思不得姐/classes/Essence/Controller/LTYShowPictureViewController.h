//
//  LTYShowPictureViewController.h
//  01-百思不得姐
//
//  Created by AYuan on 16/3/20.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTYTopic;
@interface LTYShowPictureViewController : UIViewController

/** 模型数据 */

// 传模型进来能知道图片的高度宽度 以及如何显示

@property (nonatomic, strong) LTYTopic *topic;



@end
