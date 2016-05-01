//
//  HomeController.m
//  新浪微博
//
//  Created by qinglong on 16/3/6.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "HomeController.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "Common.h"
#import "UIImage+Ext.h"
#import "StatusTool.h"

#define kMinValue       0.0f
#define kMaxValue       1.0f
#define kUnlockValue    ((kMaxValue - kMinValue) * 0.9f)

static NSString * const CellID = @"HomeCellID";
static const CGFloat TextFontSize = 16.0f;
static const CGFloat DetailTextFontSize = 11.0f;

@interface HomeController ()
{
    NSArray *_statuses;
}

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载数据
    [self p_loadData];
    
    [self setNavigationItem];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
}

#pragma mark - 私有方法
- (void)p_loadData
{
    WS(weakSelf);
    [StatusTool statusesWithSuccess:^(NSArray<Status *> *statuses) {
        _statuses = statuses;
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"Error:获取当前登录用户及其所关注（授权）用户的最新微博失败 %@", error.localizedDescription);
    }];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
        [cell.textLabel setNumberOfLines:0];
        [cell.textLabel setFont:[UIFont systemFontOfSize:TextFontSize]];
        [cell.detailTextLabel setFont:[UIFont systemFontOfSize:DetailTextFontSize]];
    }
    
    Status *s = _statuses[indexPath.row];
    [cell.textLabel setText:s.text];
    [cell.detailTextLabel setText:s.user.screen_name];
    NSURL *profileImageURL = [NSURL URLWithString:s.user.profile_image_url];
    [cell.imageView sd_setImageWithURL:profileImageURL
                      placeholderImage:[UIImage imageNamed:@"tabbar_profile_selected"]
                               options:SDWebImageLowPriority];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = tableView.bounds.size.width - 70.0f;
    
    Status *s = _statuses[indexPath.row];
    CGFloat height = [s.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:TextFontSize]}
                                          context:nil].size.height;
    height += [UIFont systemFontOfSize:DetailTextFontSize].lineHeight;
    
    return (height > 70) ? (height + 16.0f) : 70;
}

#pragma mark - UI
#pragma mark 设置导航栏
- (void)setNavigationItem
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
