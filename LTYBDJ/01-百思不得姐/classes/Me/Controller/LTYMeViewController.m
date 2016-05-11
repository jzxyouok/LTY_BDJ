//
//  LTYMeViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/3/4.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYMeViewController.h"
#import "LTYMeCell.h"
#import "LTYMeFooterView.h"
#import "LTYSettingViewController.h"

@interface LTYMeViewController ()

@end

@implementation LTYMeViewController

static NSString *LTYMeId = @"me";


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
}

- (void)setupTableView
{
    //注册cell
    [self.tableView registerClass:[LTYMeCell class] forCellReuseIdentifier:LTYMeId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = LTYGlobalBg;

    //设置header和footer
    self.tableView.sectionFooterHeight = LTYTopicCellMargin;
    self.tableView.sectionHeaderHeight = 0;
    
    //调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 825, 0);


    //设置footerView
    LTYMeFooterView *footerView = [[LTYMeFooterView alloc] init];
    self.tableView.tableFooterView = footerView;
    
    
}

- (void)setupNav
{
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    //设置导航栏右边的按钮
    UIBarButtonItem *settingButton =[UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonButton =[UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[
                                                settingButton,
                                                moonButton
                                                ];
    //设置背景色
    self.view.backgroundColor = LTYGlobalBg;

}

- (void)moonClick
{
    LTYLogFunc;
}


- (void)settingClick
{
    [self.navigationController pushViewController:[[LTYSettingViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
}


#pragma mark - <UITableViewDataSource>


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LTYMeCell *cell = [tableView dequeueReusableCellWithIdentifier:LTYMeId];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}

@end
