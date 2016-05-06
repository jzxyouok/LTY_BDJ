//
//  LTYMeFooterView.m
//  01-百思不得姐
//
//  Created by AYuan on 16/5/5.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYMeFooterView.h"
#import <AFNetworking.h>
#import "LTYSquare.h"
#import <MJExtension.h>
#import "LTYSquareButton.h"

@implementation LTYMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        //请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        //发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
        {
            NSArray *sqaures = [LTYSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
//            NSLog(@"%@",responseObject);
            
            // 创建方块
            [self createSquares:sqaures];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

    }
    return self;
}

/**
 * 创建方块
 */
- (void)createSquares:(NSArray *)sqaures
{
    // 一行最多4列
    int maxCols = 4;
    
    // 宽度和高度
    CGFloat buttonW = LTYScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i<sqaures.count; i++) {
        // 创建按钮
        LTYSquareButton *button = [LTYSquareButton buttonWithType:UIButtonTypeCustom];
        // 监听点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 传递模型
        button.square = sqaures[i];
        [self addSubview:button];
        
        // 计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }
    
    // 8个方块, 每行显示4个, 计算行数 8/4 == 2 2
    // 9个方块, 每行显示4个, 计算行数 9/4 == 2 3
    // 7个方块, 每行显示4个, 计算行数 7/4 == 1 2
    
    // 总行数
    //    NSUInteger rows = sqaures.count / maxCols;
    //    if (sqaures.count % maxCols) { // 不能整除, + 1
    //        rows++;
    //    }
    
    // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    
    NSUInteger rows = (sqaures.count + maxCols - 1) / maxCols;
    
    // 计算footer的高度
    self.height = rows * buttonH;
    
    // 重绘
    [self setNeedsDisplay];
}- (void)buttonClick:(UIButton *)button
{
    LTYLogFunc;
}

/**
 因为UIView没有image属性也没有backgroudImage属性，所以要搞背景图片必须画到上面去
 */
- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
}



@end
