//
//  OauthAccountTool.h
//  新浪微博
//
//  Created by qinglong on 16/4/22.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OauthAccount.h"

@interface OauthAccountTool : NSObject

// 获取用户数据
+ (OauthAccount *)oauthAccount;

// 保存用户数据
+ (void)saveOauthAccount:(OauthAccount *)account;

@end
