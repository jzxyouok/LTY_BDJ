//
//  LTYRecommendCategoryCell.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/9.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYRecommendCategoryCell.h"
#import "LTYRecommendCategory.h"

@interface LTYRecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *selectIndicator;

@end

@implementation LTYRecommendCategoryCell

- (void)awakeFromNib {
    
    //当cell的selection为None时，即使cell被选中了，内部的子控件就不会进入高亮状态
    self.backgroundColor = LTYRGBColor(244, 244, 244);
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = bg;
    self.selectIndicator.backgroundColor = LTYRGBColor(219, 21, 26);
}

- (void)setCategory:(LTYRecommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //重新调整内部textLabel的frame, 以免挡住部分分割线
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

/**
 可以在这个方中监听cell的选中和取消选中
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.selectIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectIndicator.backgroundColor : LTYRGBColor(78, 78, 78);

    //     NSLog(@"%@----%d",self.category.name,selected);
    
}

@end
