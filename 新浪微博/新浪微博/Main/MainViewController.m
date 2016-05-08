//
//  ViewController.m
//  新浪微博
//
//  Created by qinglong on 16/2/21.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "MainViewController.h"
#import "Common.h"

#import "Dock.h"
#import "HomeController.h"
#import "MessageController.h"
#import "MeController.h"
#import "SquareController.h"
#import "MoreController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    // 1. 添加控制器
    [self addControllers];
    // 2. 添加项目
    [self addDockItems];
}

#pragma mark - 私有方法
#pragma mark 添加项目
- (void)addDockItems
{
    [self.dock addDockItem:@"主页" icon:@"tabbar_home" selectedIcon:@"tabbar_home_selected"];
    [self.dock addDockItem:@"消息" icon:@"tabbar_message_center" selectedIcon:@"tabbar_message_center_selected"];
    [self.dock addDockItem:@"我" icon:@"tabbar_profile" selectedIcon:@"tabbar_profile_selected"];
    [self.dock addDockItem:@"广场" icon:@"tabbar_discover" selectedIcon:@"tabbar_discover_selected"];
    [self.dock addDockItem:@"更多" icon:@"tabbar_more" selectedIcon:@"tabbar_more_selected"];
}

#pragma mark 添加控制器
- (void)addControllers
{
    HomeController *home = [[HomeController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    [self addChildViewController:homeNav];
    
    MessageController *msg = [[MessageController alloc] init];
    UINavigationController *msgNav = [[UINavigationController alloc] initWithRootViewController:msg];
    [self addChildViewController:msgNav];
    
    MeController *me = [[MeController alloc] init];
    UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:me];
    [self addChildViewController:meNav];
    
    SquareController *square = [[SquareController alloc] init];
    UINavigationController *squareNav = [[UINavigationController alloc] initWithRootViewController:square];
    [self addChildViewController:squareNav];
    
    MoreController *more = [[MoreController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *moreNav = [[UINavigationController alloc] initWithRootViewController:more];
    [self addChildViewController:moreNav];
    
    // apperance方法返回一个导航栏的外观对象
    // 修改了这个外观对象，相当于修改了整个项目的外观
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbar_background"]]];
}

@end
