//
//  LTYTopic.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/16.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYTopic.h"
#import "LTYTopicViewController.h"
#import "LTYComment.h"
#import "LTYUser.h"

@interface LTYTopic()
{
    //成员变量写在implementation中默认为私有
    //不用自己写成员变量，readonly会帮你自动生成,除非你自己实现getter
    CGFloat _cellHeight;
//    CGRect _pictureF;
}

@end

@implementation LTYTopic


+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             };
}

+ (NSDictionary *)objectClassInArray
{
//    return @{@"top_cmt" : [LTYComment class]};
    return @{@"top_cmt" : @"LTYComment"};
    
}

- (NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
}

/**
 如果你把get方法或set方法自己实现了，编译器不会帮你自动生成带下划线的成员变量
 所以得自己写成员变量
 */
- (CGFloat)cellHeight
{
    
    if (!_cellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake(LTYScreenW - 4 * LTYTopicCellMargin, MAXFLOAT);
        //    CGFloat textH = [topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize].height;
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        // cell的高度
        //文字部分的高度
        _cellHeight = LTYTopicCellTextY + textH + LTYTopicCellMargin;
        
        //根据段子的类型来计算cell的高度
        //在模型里面算frame，在cell中给他传模型传数据
        if (self.type == LTYTopicTypePicture) { //图片帖子
            //图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            //图片显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            
            if (pictureH > LTYTopicCellPictureMaxH) { //如果是大图
                pictureH = LTYTopicCellPictureBreakH; //压缩显示高度
                self.bigPicture = YES; //标志为大图
            }
            
            //计算图片控件的frame
            CGFloat pictureX = LTYTopicCellMargin;
            CGFloat pictureY = LTYTopicCellTextY + textH + LTYTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            _cellHeight += pictureH + LTYTopicCellMargin;
            
        } else if (self.type == LTYTopicTypeVoice) { // 声音帖子
            
            CGFloat voiceX = LTYTopicCellMargin;
            CGFloat voiceY = LTYTopicCellTextY + textH + LTYTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + LTYTopicCellMargin;
        } else if (self.type == LTYTopicTypeVideo) { //视频帖子
            
            CGFloat videoX = LTYTopicCellMargin;
            CGFloat videoY = LTYTopicCellTextY + textH + LTYTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + LTYTopicCellMargin;

        }
        
        //如果有最热评论
        LTYComment *cmt = self.top_cmt;
        
        if (cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@",cmt.user,cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += LTYTopicCellTopCmtTitleH + contentH +LTYTopicCellMargin;
            
            
            
        }
        
        // 底部工具条的高度
        _cellHeight += LTYTopicCellBottomBarH + LTYTopicCellMargin;
        
    }
    return _cellHeight;
}




























@end
