//
//  Status.h
//  新浪微博
//
//  Created by qinglong on 16/4/24.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Status : NSObject
// 微博内容
@property (copy, nonatomic) NSString *text;

// 用户
@property (strong, nonatomic) User *user;

@end
