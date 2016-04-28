//
//  LTYCommentViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/4/1.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYCommentViewController.h"
#import "LTYTopicCell.h"
#import "LTYTopic.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "LTYComment.h"
#import <MJExtension.h>
#import "LTYCommentCell.h"

static NSString * const ID = @"comment";

@interface LTYCommentViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotcomments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;
/** 保存帖子的 top_cmt */
@property (nonatomic, strong) LTYComment *saved_top_cmt;


@end

@implementation LTYCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupHeader];
    
    [self setupRefresh];
    
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewComments
{
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //最热评论
        self.hotcomments = [LTYComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        
        //最新评论
        self.latestComments = [LTYComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)setupHeader
{
    //设置header
    UIView *header = [[UIView alloc] init];
    
    //清空 top_cmt
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        //让cellHeight重新算一遍(cellHeight是一次性设置的，所以得清空才能重算)
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    
    //添加cell
    LTYTopicCell *cell = [LTYTopicCell topicCell];
    cell.topics = self.topic;
    cell.size = CGSizeMake(LTYScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    
    //header的高度
    header.height = self.topic.cellHeight + LTYTopicCellMargin;
    
    self.tableView.tableHeaderView = header;
}



- (void)setupBasic
{
    self.title = @"评论";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImgae:@"comment_nav_item_share_icon_click" targrt:nil action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //cellHeight
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //设置背景色
    self.tableView.backgroundColor = LTYGlobalBg;
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LTYCommentCell class]) bundle:nil] forCellReuseIdentifier:ID];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    //拿到键盘弹出后的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //修改底部约束
    self.bottomSpace.constant = LTYScreenH - frame.origin.y;
    //动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //恢复帖子的top_cmt
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
}

/**
 返回第session组的所有评论数组
 */
- (NSArray *)commentsInSession:(NSInteger)session
{
    if (session == 0) {
        return self.hotcomments.count ? self.hotcomments : self.latestComments;
    }
    return self.latestComments;
}

- (LTYComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSession:indexPath.section][indexPath.row];
}

#pragma mark - UITableViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotcomments.count;
    NSInteger latesCount = self.latestComments.count;
    if (hotCount) return 2;
    if (latesCount) return 1;
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger hotCount = self.hotcomments.count;
    NSInteger latesCount = self.latestComments.count;
    
    if (section == 0) return hotCount ? hotCount : latesCount;
    return latesCount;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //创建头部
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = LTYGlobalBg;
    //创建label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = LTYRGBColor(67, 67, 67);
    label.width = 200;
    label.x = LTYTopicCellMargin;
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [header addSubview:label];
    
    //设置文字
    NSInteger hotCount = self.hotcomments.count;

    if (section == 0) {
        
        label.text = hotCount ? @"热门评论" : @"最新评论";
    } else {
        label.text = @"最新评论";
    }

    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTYCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.comment = [self commentInIndexPath:indexPath];
  

    return cell;
}










@end
