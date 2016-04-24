//
//  MoreController.m
//  新浪微博
//
//  Created by qinglong on 16/3/6.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "MoreController.h"
#import "UIImage+Ext.h"
#import "GroupCell.h"

NSString * const kCellID = @"MoreCellID";

@interface LogoutBtn : UIButton

@end

@implementation LogoutBtn

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat w = contentRect.size.width * 0.75;
    CGFloat h = contentRect.size.height;
    CGFloat x = (contentRect.size.width - w) / 2.0f;
    CGFloat y = 0;
    
    return CGRectMake(x, y, w, h);
}

@end


@interface MoreController ()

@property (strong, nonatomic, readonly) NSArray *dataList;

@end

@implementation MoreController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // 加载数据
    [self loadData];
    
    // 设置界面
    [self setupUI];
}

#pragma mark - 私有方法
#pragma mark 加载数据
- (void)loadData
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"More.plist" ofType:nil];
    _dataList = [NSArray arrayWithContentsOfFile:filePath];
}

#pragma mark 设置界面
- (void)setupUI
{
    [self.navigationItem setTitle:@"更多"];
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithTitle:@"设置"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(clickSetting)];
    [settingItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [settingItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [settingItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    self.navigationItem.rightBarButtonItem = settingItem;
    
    // 注册单元格
    [self.tableView registerClass:[GroupCell class] forCellReuseIdentifier:kCellID];
    
    [self addLogOutButton];
}

#pragma mark 添加退出登录按钮
- (void)addLogOutButton
{
    LogoutBtn *logout = [LogoutBtn buttonWithType:UIButtonTypeCustom];
    [logout setTitle:@"退出登录" forState:UIControlStateNormal];
    [logout setImage:[UIImage resizedImage:@"common_button_big_red"] forState:UIControlStateNormal];
    [logout setImage:[UIImage resizedImage:@"common_button_big_red_highlighted"] forState:UIControlStateHighlighted];
    [logout addTarget:self action:@selector(clickLogout) forControlEvents:UIControlEventTouchUpInside];
    // 需要设置高度，否则无法显示
    logout.bounds = CGRectMake(0, 0, 0, 44.0f);
    // 将按钮加到底部视图
    self.tableView.tableFooterView = logout;
    
    // 增加底部滑动区域，使得按钮可稍上移一些
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10.0f, 0);
}

#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    NSString *name = self.dataList[indexPath.section][indexPath.row][@"name"];
    [cell.textLabel setText:name];
    
    if (indexPath.section == 2) {
        [cell setCellType:kGroupCellTypeRightLabel];
        [cell.rightLabel setText:((indexPath.row == 0) ? @"有图模式" : @"经典主题")];
    } else {
        [cell setCellType:kGroupCellTypeIndicator];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == (self.dataList.count - 1))
    {
        return 10.0f;
    } else {
        return 16.0f;
    }
}

#pragma mark - 监听方法
#pragma mark 点击设置
- (void)clickSetting
{
    NSLog(@"click setting");
}

#pragma mark 点击退出登录
- (void)clickLogout
{
    NSLog(@"click logout");
}


@end
