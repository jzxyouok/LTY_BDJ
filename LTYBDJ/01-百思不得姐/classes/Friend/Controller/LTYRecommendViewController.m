//
//  LTYRecommendViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/9.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYRecommendViewController.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import "LTYRecommendCategory.h"
#import <MJExtension.h>
#import "LTYRecommendCategoryCell.h"
#import "LTYRecommendUserTableViewCell.h"
#import "LTYRecommendUser.h"
#import <MJRefresh.h>

#define LTYSelectCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface LTYRecommendViewController () <UITableViewDelegate,UITableViewDataSource>

/** 左边的categories数据 */
@property (nonatomic, strong) NSArray *categories;
/** 右边的user数据 */
//@property (nonatomic, strong) NSArray *users;
/** 左边的categoryTableView */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/**  右边的userTableView */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *params;

/** AFN的请求管理者(所有请求都交给他来管理，他会放在请求队列中) */
@property (nonatomic, strong) AFHTTPSessionManager *manager;



@end

@implementation LTYRecommendViewController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

static NSString * const LTYCategoryId = @"category";
static NSString * const LTYUserId = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化控制器view
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
    //加载左侧数据
    [self loadCategoreis];
    
}

- (void)loadCategoreis
{
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //服务器返回的JSON数据
        self.categories = [LTYRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //        NSLog(@"%@",responseObject[@"list"]);
        
        //刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        //让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];

}

/**
  初始化控制器view
 */
- (void)setupTableView
{
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LTYRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:LTYCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LTYRecommendUserTableViewCell class]) bundle:nil] forCellReuseIdentifier:LTYUserId];
    
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.rowHeight = 70;
    
    //设置标题
    self.title = @"推荐关注";
    
    //设置背景色
    self.view.backgroundColor = LTYGlobalBg;

}

/**
 添加刷新控件
 */
- (void)setupRefresh
{
    //下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    //上拉刷新
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
//    self.userTableView.mj_footer.hidden = YES;
    
}

#pragma mark - 加载用户数据

/**
 下拉刷新
 */
- (void)loadNewUsers
{
    LTYRecommendCategory *rc = LTYSelectCategory;
    //第一页
    rc.currentPage = 1;
    
    //发送请求给服务器，加载右侧的数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(rc.ID);
    parameters[@"page"] = @(rc.currentPage);
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //字典数组 -> 模型数组
        NSArray *users = [LTYRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //清楚所有旧数据（下拉刷新的时候清楚之前的数据，不然数据在后面又会叠加重复）
        [rc.users removeAllObjects];
        
        //添加到当前类别对应的用户数组中
        [rc.users addObjectsFromArray:users];
        
        //保存总数
        rc.total = [responseObject[@"total"] integerValue];
        
//        //如果连续点击多个类别,只处理最后一次请求
//        if (self.params != parameters) return;
        
        if (rc.total == rc.users.count) { //全部加载完毕
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        //刷新右边的表格
        [self.userTableView reloadData];
        
        //刷新完毕后底部控件结束刷新
        [self checkFooterState];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //显示失败信息
        LTYLog(@"%@",error);
        
    }];

}

/**
 上拉刷新
 */
- (void)loadMoreUsers
{
    LTYRecommendCategory *c = LTYSelectCategory;
    
    //发送请求给服务器，加载右侧的数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    //因为基本数据类型要包装成对象才能放到字典中，所以为@()
    //数组因为返回的是id类型所以不能用点语法，所以为[LTYSelectCategory id]
    parameters[@"category_id"] = @(c.ID);
    parameters[@"page"] = @(++c.currentPage);
    self.params = parameters;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //字典数组 -> 模型数组
        NSArray *users = [LTYRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别对应的用户数组中
        [c.users addObjectsFromArray:users];
        
        //如果连续点击多个类别,只处理最后一次请求
        if (self.params != parameters) return;
        
        //刷新右边的表格
        [self.userTableView reloadData];
        
        //刷新完毕后底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != parameters) return;
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        //让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
        
    }];

}

/**
 时刻监测footer的状态
 */
- (void)checkFooterState
{
    LTYRecommendCategory *c = LTYSelectCategory;
    //刷新完毕后底部控件结束刷新
    if (c.total == c.users.count) { //全部加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else { //还没有加载完毕
        [self.userTableView.mj_footer endRefreshing];
    }
    
    //每次刷新右边数据时，都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (c.users.count == 0);

}

#pragma mark - <UITableViewDataSource>

/**
 每次刷新表格后想做些事情可以在这里做，因为每次刷新都会来带这个方法
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //左边的类别表格
    if (tableView == self.categoryTableView) return self.categories.count;
    
    //监测footer的状态
    [self checkFooterState];
    
    //右边的用户表格
    return [LTYSelectCategory users].count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) { //左边的类型表格
        LTYRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:LTYCategoryId ];
        
        cell.category = self.categories[indexPath.row];
        
        return cell;
        
    } else {   //右边用户表格
        
        //左边被选中的类别模型
        LTYRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        LTYRecommendUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LTYUserId];
        cell.user = c.users[indexPath.row];
        return cell;
        
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    LTYRecommendCategory *c = self.categories[indexPath.row];
    
    
    if (c.users.count) {
        //显示曾经的数据
        [self.userTableView reloadData];
    } else {
        
        //赶紧刷新表格,目的是:马上显示当前category的用户数据，不让用户看上一个category的残留数据
        [self.userTableView reloadData];
    
        // 马上进入刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
    }
}

#pragma mark - 控制器销毁
/**
 如果控制器死了要把之前的所有请求操作停掉
 */
- (void)dealloc
{
    //停止所有的操作
    [self.manager.operationQueue cancelAllOperations];
    //或者直接拿到task的cancel方法
}


@end
