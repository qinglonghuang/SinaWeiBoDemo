//
//  HomeController.m
//  新浪微博
//
//  Created by qinglong on 16/3/6.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "HomeController.h"
#import <Masonry.h>
#import "Common.h"
#import "UIImage+Ext.h"
#import "StatusTool.h"
#import "StatusCell.h"
#import "MJRefresh.h"

#define kMinValue       0.0f
#define kMaxValue       1.0f
#define kUnlockValue    ((kMaxValue - kMinValue) * 0.9f)

static NSString * const CellID = @"HomeCellID";

@interface HomeController ()<MJRefreshBaseViewDelegate>
{
    NSMutableArray *_statusFramesM;
}

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
     _statusFramesM = [NSMutableArray array];
    
    // 1.添加刷新视图
    [self p_addRefreshView];
    // 2.添加导航栏
    [self p_addNavigationItem];
    // 3.设置TableView
    [self p_tableViewSetting];
}

#pragma mark - 私有方法
#pragma mark 添加刷新控件
- (void)p_addRefreshView
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    [header setDelegate:self];
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    [footer setDelegate:self];
    
    [header beginRefreshing];
}

#pragma mark 设置TableView
- (void)p_tableViewSetting
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [self.tableView setBackgroundColor:kGlobalBgColor];
}

#pragma mark - 监听方法
#pragma mark 编辑
- (void)compose
{
    NSLog(@"compose");
}

#pragma mark 弹框
- (void)pop
{
    NSLog(@"pop");
}

#pragma mark - 代理方法
#pragma mark 刷新代理方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    WS(weakSelf);
    long long sinceID = 0;
    long long maxID = 0;
    
    if (_statusFramesM.count > 0) {
        if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
            StatusCellFrame *f = _statusFramesM.firstObject;
            sinceID = f.status.ID; // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
        } else {
            StatusCellFrame *f = _statusFramesM.lastObject;
            maxID = f.status.ID - 1; // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0
        }
    }

    [StatusTool statusesWithSinceID:sinceID maxID:maxID success:^(NSArray<Status *> *statuses) {
        [refreshView endRefreshing];
        if (statuses.count > 0) {
            NSMutableArray *newFrames = [NSMutableArray arrayWithCapacity:statuses.count];
            for (Status *s in statuses) {
                StatusCellFrame *f = [[StatusCellFrame alloc] init];
                f.status = s;
                [newFrames addObject:f];
            }
            
            NSInteger location = maxID ? _statusFramesM.count : 0;
            [_statusFramesM insertObjects:newFrames
                                atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(location, newFrames.count)]];
            
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"Error:获取当前登录用户及其所关注（授权）用户的最新微博失败 %@", error.localizedDescription);
        [refreshView endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _statusFramesM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }

    cell.statusCellFrame = _statusFramesM[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_statusFramesM[indexPath.row] cellHeight];
}

#pragma mark - UI
#pragma mark 添加导航栏
- (void)p_addNavigationItem
{
    [self.navigationItem setTitle:@"主页"];
    
    UIButton *leftBtn = [[UIButton alloc] init];
    UIImage *leftImage = [UIImage imageNamed:@"navigationbar_compose"];
    [leftBtn setBackgroundImage:leftImage forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_compose_highlighted"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    // 设置尺寸，否则无法显示
    leftBtn.bounds = (CGRect){CGPointZero, leftImage.size};
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] init];
    UIImage *rightImage = [UIImage imageNamed:@"navigationbar_pop"];
    [rightBtn setBackgroundImage:rightImage forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    // 设置尺寸，否则无法显示
    rightBtn.bounds = (CGRect){CGPointZero, rightImage.size};
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
}

@end
