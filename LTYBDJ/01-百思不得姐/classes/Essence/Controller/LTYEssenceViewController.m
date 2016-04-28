//
//  LTYEssenceViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/4.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYEssenceViewController.h"
#import "LTYRecommendTagsViewController.h"
#import "LTYTopicViewController.h"


@interface LTYEssenceViewController () <UIScrollViewDelegate>

/**
 标签栏底部的红色指示器
 */
@property (nonatomic, weak) UIView *indicatorView;

/**当前选中的标签按钮*/
@property (nonatomic, weak) UIButton *currentSelectedBtn;
/**顶部标签栏*/
@property (nonatomic, weak) UIView *titlesView;
/**底部的所有内容*/
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation LTYEssenceViewController

- (void)viewDidLoad {

    //设置导航栏
    [self setupNav];
    
    //初始化子控制器
    [self setupChildVces];
    
    //设置顶部的标签栏
    [self setupTitleView];
    
    //底部的scrollview
    [self setupContentView];
    
    
    
}

/**
 初始化子控制器
 */
- (void)setupChildVces
{
    LTYTopicViewController *all = [[LTYTopicViewController alloc] init];
    all.title = @"全部";
    all.type = LTYTopicTypeAll;
    [self addChildViewController:all];
    
    LTYTopicViewController *video = [[LTYTopicViewController alloc] init];
    video.title = @"视频";
    video.type = LTYTopicTypeVideo;
    [self addChildViewController:video];
    
    LTYTopicViewController *voice = [[LTYTopicViewController alloc] init];
    voice.title = @"音频";
    voice.type = LTYTopicTypeVoice;
    [self addChildViewController:voice];
    
    LTYTopicViewController *picture = [[LTYTopicViewController alloc] init];
    picture.title = @"图片";
    picture.type = LTYTopicTypePicture;
    [self addChildViewController:picture];
    
    LTYTopicViewController *word = [[LTYTopicViewController alloc] init];
    word.title = @"段子";
    word.type = LTYTopicTypeWord;
    [self addChildViewController:word];
    
}

/**
 底部的scrollview
 */
- (void)setupContentView
{
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
   
    [self.view insertSubview:contentView atIndex:0];
     contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.currentSelectedBtn.enabled = YES;
    button.enabled = NO;
    self.currentSelectedBtn = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
}


/**
 设置顶部的标签栏
 */
- (void)setupTitleView
{
    //标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    indicatorView.tag = -1;
    self.indicatorView = indicatorView;
    
    //内部的子标签
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        //设置了文字之后强制布局，以便于底部红色指示器拿着文字label的宽度设置自己的宽度
//        [button layoutIfNeeded]; //强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        //默认点击了第一个按钮
        if (i == 0) {
//            [self titleClick:button];
            
            button.enabled = NO;
            self.currentSelectedBtn = button;
            
            //让按钮内部的label根据文字内容来计算尺寸以便于底部红色指示器拿着文字label的宽度设置自己的宽度
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
            
        }
    }
    [titlesView addSubview:indicatorView];
}

/**
 设置导航栏
 */
- (void)setupNav
{
    //设置导航栏标题
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.title = @"AYuan";
    
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    //设置背景色
    self.view.backgroundColor = LTYGlobalBg;
    
}

- (void)tagClick
{
    LTYRecommendTagsViewController *rtVc = [[LTYRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:rtVc animated:YES];
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; //设置控制器view的y值为0(默认是20)
    //设置控制器的view的height为整个屏幕的高度(默认是比屏幕高度少20)
    //系统自动创建出来的控制器view会自动添加20，但是你自己创建出来的控制器view要自己手动加一下
    vc.view.height = scrollView.height; //设置控制器的view的height为整个屏幕的高度(默认是比屏幕高度少20)
  
    [scrollView addSubview:vc.view];
    
}

/** 停止减速后(手动拖拽)*/
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}


@end
