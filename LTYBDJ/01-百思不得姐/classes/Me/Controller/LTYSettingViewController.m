//
//  LTYSettingViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/5/11.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYSettingViewController.h"
#import <SDImageCache.h>

@implementation LTYSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = LTYGlobalBg;
    self.title = @"设置";
    //图片缓存
    [self getSize];
    
    
    
}

- (void)getSize2
{
    //图片缓存
    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    //    LTYLog(@"%zd %@",size,NSTemporaryDirectory());
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cachePath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    //获得文件夹内部的所有内容(这种方法不能获取子文件夹)
//    NSArray *contens = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachePath error:nil];
    NSArray *subpaths = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    LTYLog(@"%@",subpaths);

}

- (void)getSize
{
    //因为获取缓存是一个个遍历很耗时的，所以在获取缓存的时候放在子线程中进行，获取完毕之后回到主线程刷新UI
    //因为这里比较简单就没有放在子线程中

    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    //    LTYLog(@"%zd %@",size,NSTemporaryDirectory());
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cachePath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:cachePath];
    NSInteger totalSize = 0;
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        
//        BOOL dir = NO;
//        判断文件的类型 ： 文件/文件夹
//        [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&dir];
//        if(dir) continue;
        
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
        totalSize += [attrs[NSFileSize] integerValue];
//        NSInteger size = [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil][NSFileSize] integerValue];
//        totalSize += size;
    }
    LTYLog(@"%zd",totalSize);
    

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    CGFloat size = [SDImageCache sharedImageCache].getSize / 1000.0 /1000 ;//mac中是按照1000来算的
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(已使用%.1fMB)",size];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //自己手动来清除缓存
//    [[NSFileManager defaultManager] removeItemAtPath:<#(nonnull NSString *)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>]
    
    [[SDImageCache sharedImageCache] cleanDisk];

}

@end
