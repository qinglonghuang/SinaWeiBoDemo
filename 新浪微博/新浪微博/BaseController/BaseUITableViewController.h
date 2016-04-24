//
//  BaseUITableViewController.h
//  新浪微博
//
//  Created by qinglong on 16/4/24.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboHttpTool.h"

@interface BaseUITableViewController : UITableViewController

@property (readonly, weak, nonatomic) WeiboHttpTool *WBHttp;

@end
