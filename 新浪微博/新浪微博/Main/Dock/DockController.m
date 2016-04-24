//
//  DockController.m
//  新浪微博
//
//  Created by qinglong on 16/3/6.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "DockController.h"
#import "Common.h"

@interface DockController () <DockDelegate>

@end

@implementation DockController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addDock];
}

#pragma mark - 私有方法
#pragma mark 增加项目条
- (void)addDock
{
    Dock *dock = [[Dock alloc] init];
    [dock setDelegate:self];
    [self.view addSubview:dock];
    _dock = dock;
    WS(weakSelf);
    [dock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.view);
        make.height.equalTo(@44.0f);
    }];
}

#pragma mark - 代理方法
#pragma mark 切换选项
- (void)dock:(Dock *)dock didSelectedFrom:(NSInteger)from to:(NSInteger)to
{
    UIViewController *preController = self.childViewControllers[from];
    UIViewController *curController = self.childViewControllers[to];
    
    [preController.view removeFromSuperview];
    [self.view addSubview:curController.view];
    WS(weakSelf);
    [curController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.dock.mas_top);
    }];
}

@end
