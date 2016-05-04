//
//  LTYRecommendTagCell.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/12.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYRecommendTagCell.h"
#import "LTYRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface LTYRecommendTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumLabel;

@end

@implementation LTYRecommendTagCell

- (void)setRecommendTag:(LTYRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconView.image = image ? [image circleImage] : placeholder;
    }];
    self.nameLabel.text = _recommendTag.theme_name;
    
    NSString *subNumber = nil;
    
    if (_recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅",_recommendTag.sub_number];
    } else { //大于等于1万人
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅",_recommendTag.sub_number / 10000.0];
    }
    self.subNumLabel.text = subNumber;
    
}

/**
 如果不想别人改变你的尺寸，就重写setFrame
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    //把frame传给super的方法保存
    [super setFrame:frame];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
