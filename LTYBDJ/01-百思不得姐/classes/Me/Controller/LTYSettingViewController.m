//
//  LTYSettingViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/5/11.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYSettingViewController.h"
#import "SDImageCache.h"


@interface LTYSettingViewController()<UIActionSheetDelegate>

@end

@implementation LTYSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    
}


#pragma mark - <UITableviewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"当前版本:1.01"];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else if (indexPath.row == 1) {
        CGFloat size = [SDImageCache sharedImageCache].getSize / 1000.0 /1000 ;//mac中是按照1000来算的
        cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(已使用%.1fMB)",size];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else if (indexPath.row == 2) {
        
        cell.textLabel.text = @"用户协议";
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    return cell;
}

#pragma mark - <UITableviewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
        sheet.delegate = self;
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
    }else if(indexPath.row == 2) {
      

        
    }
}

#pragma mark - <UIActionSheetDelegate>

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) { //点击确定后做的事情
        
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *cachePath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
        
        [self clearCache:cachePath];
        
        NSUInteger size2 = [SDImageCache sharedImageCache].getSize;
        
        [self.tableView reloadData];
        
    }
    
}

- (void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}



@end
