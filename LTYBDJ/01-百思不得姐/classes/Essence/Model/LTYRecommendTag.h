//
//  LTYRecommendTag.h
//  01-百思不得姐
//
//  Created by AYuan on 16/3/12.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTYRecommendTag : NSObject

/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;

@end
