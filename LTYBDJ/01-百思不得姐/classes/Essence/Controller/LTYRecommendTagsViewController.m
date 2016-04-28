//
//  LTYRecommendTagsViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/12.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYRecommendTagsViewController.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "LTYRecommendTag.h"
#import "LTYRecommendTagCell.h"

@interface LTYRecommendTagsViewController ()

/** tags */
@property (nonatomic, strong) NSArray *tags;


@end
 
@implementation LTYRecommendTagsViewController

static NSString * const LTYTagId = @"tag";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化控制器
    [self setupTableView];
    
    //加载数据
    [self logTags];
    
}

- (void)logTags
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        self.tags = [LTYRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
    }];
}

- (void)setupTableView
{
    self.title = @"推荐标签";
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellStyleDefault;
    self.tableView.backgroundColor = LTYGlobalBg;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LTYRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:LTYTagId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tags.count;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTYRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:LTYTagId];
    cell.recommendTag = self.tags[indexPath.row];
    return cell;
    
}


@end
