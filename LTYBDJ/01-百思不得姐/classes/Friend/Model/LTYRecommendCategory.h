//
//  LTYRecommendCategory.h
//  01-百思不得姐
//
//  Created by AYuan on 16/3/9.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTYRecommendCategory : NSObject

/** ID */
@property (nonatomic, assign) NSInteger ID;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;

/** user模型数据 */
@property (nonatomic, strong) NSMutableArray *users;

/** 加载的用户数 */
@property (nonatomic, assign) NSInteger total;

/** 当前页码*/
@property (nonatomic, assign) NSInteger currentPage;

@end
