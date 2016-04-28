//
//  LTYRecommendUserTableViewCell.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/10.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYRecommendUserTableViewCell.h"
#import "LTYRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface LTYRecommendUserTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;



@end

@implementation LTYRecommendUserTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(LTYRecommendUser *)user
{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    NSString *fansCount = nil;
    if (_user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人订阅",_user.fans_count ];
    } else { //大于等于1万人
        fansCount = [NSString stringWithFormat:@"%.1f万人订阅",_user.fans_count / 10000.0];
    }
    self.fansCountLabel.text = fansCount;

}

@end
