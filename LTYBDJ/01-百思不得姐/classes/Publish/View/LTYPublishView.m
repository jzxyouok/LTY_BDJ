//
//  LTYPublishView.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/21.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYPublishView.h"
#import "LTYVerticalButton.h"
#import <POP.h>
#import "LTYPostWordViewController.h"
#import "LTYNavigationController.h"
#import "LTYLoginTool.h"

static CGFloat const LTYAnimationDelay = 0.08;
static CGFloat const LTYSpringFactor = 7;

//#define LTYRootView [UIApplication sharedApplication].keyWindow.rootViewController.view

@interface LTYPublishView ()

/**  定义属性block */
//@property (nonatomic, copy) void (^completionClock)();

@end

@implementation LTYPublishView


+ (instancetype)publishView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

//成员变量下划线在名字前面，全局变量下划线在后面（命名规范）
static UIWindow *window_;

+ (void)show
{
    //搞一个window 与其他window没有任何关系 这个window永远在上面除非你销毁
    //创建窗口
    window_ = [[UIWindow alloc] init]; //init后不写默认级别，盖不住状态栏
    window_.hidden = NO;
    window_.frame = [UIScreen mainScreen].bounds;
    window_.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    //添加发布界面
    LTYPublishView *publishView = [LTYPublishView publishView];
    publishView.frame = window_.bounds;
    [window_ addSubview:publishView];
    
}

- (void)awakeFromNib {



    //先让控制器view不能点击(父控件不能点击，子控件就不能点击了)
//    LTYRootView.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    //中间的6个按钮
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (LTYScreenH - 2 * buttonH) * 0.5;
    int maxCols = 3;
    CGFloat buttonStartX = 15;
    CGFloat xMargin = (LTYScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i < images.count; i++) {
        LTYVerticalButton *button = [[LTYVerticalButton alloc] init];
        [self addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        //设置内容
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        //计算X\Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (buttonW + xMargin);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - LTYScreenH;
        
        //添加动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = LTYSpringFactor;
        anim.springSpeed = LTYSpringFactor;
        anim.beginTime = CACurrentMediaTime() + i * LTYAnimationDelay;
        [button pop_addAnimation:anim forKey:nil];
        
}
    
    //添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:sloganView];
    
    //标语动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = LTYScreenW * 0.5;
    CGFloat centerEndY = LTYScreenH * 0.2;
    CGFloat centerBeginY = centerEndY - LTYScreenH;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * LTYAnimationDelay;
    anim.springSpeed = LTYSpringFactor;
    anim.springBounciness = LTYSpringFactor;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
       //标语动画执行完毕，恢复点击事件
//        LTYRootView.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
        
    }];
    //如果不是想通过key找到这个动画则可以不用传
    [sloganView pop_addAnimation:anim forKey:nil];
    
}

/**
 先执行退出动画,动画完毕后执行completionClock
 */
- (void)cancelWithCompletionClock:(void (^)())completionClock
{
    //让控制器的view不能被点击
//    LTYRootView.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    
    int beginIndex = 1;
    for (int i = beginIndex; i < self.subviews.count; i++) {
        
        UIView *subView = self.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerEndY = subView.centerY + LTYScreenH;
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerEndY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex)  * LTYAnimationDelay;
        [subView pop_addAnimation:anim forKey:nil];
        
        //监听最后一个动画
        if (i == self.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
//                [self removeFromSuperview];
            
                //销毁窗口
                window_ = nil;
                
                //要判断block是否为空，如果为ni调用的话会报错
                !completionClock ? : completionClock();
//                LTYRootView.userInteractionEnabled = YES;
//                self.userInteractionEnabled = YES;
            }];
        }
        
    }

}
- (void)buttonClick:(UIButton *)button
{
    [self cancelWithCompletionClock:^{
        if (button.tag == 2) {
            
            //判断是否登录
            if ([LTYLoginTool getUid:YES] == nil) return;
            NSLog(@"发段子");
            
            
            
            //这里不能用self来弹出其他控制器，因为self执行了dissmiss操作
            LTYNavigationController *navVc = [[LTYNavigationController alloc] init];
            LTYPostWordViewController *postWordVc = [[LTYPostWordViewController alloc] init];
            UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
            [navVc pushViewController:postWordVc animated:YES];
            [rootVc presentViewController:navVc animated:YES completion:nil];
        }
    }];
    
}

- (IBAction)cancel {
    
    [self cancelWithCompletionClock:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancelWithCompletionClock:nil];
}

@end
