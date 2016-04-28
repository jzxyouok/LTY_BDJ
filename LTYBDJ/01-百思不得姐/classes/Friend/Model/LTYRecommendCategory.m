//
//  LTYRecommendCategory.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/9.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYRecommendCategory.h"

@implementation LTYRecommendCategory

- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}


+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}


@end
