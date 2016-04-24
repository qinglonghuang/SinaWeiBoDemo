//
//  BaseUITableViewController.m
//  新浪微博
//
//  Created by qinglong on 16/4/24.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "BaseUITableViewController.h"

@implementation BaseUITableViewController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _WBHttp = [WeiboHttpTool shareTool];
    }
    
    return self;
}

@end
