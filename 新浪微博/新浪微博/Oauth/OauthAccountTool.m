//
//  OauthAccountTool.m
//  新浪微博
//
//  Created by qinglong on 16/4/22.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "OauthAccountTool.h"
#import "HQLSandboxUtils.h"

NSString * const AccountPlistName = @"account.plist";

@implementation OauthAccountTool

#pragma mark 获取用户数据
+ (OauthAccount *)oauthAccount
{
    NSString *path = [[HQLSandboxUtils documentDir] stringByAppendingPathComponent:AccountPlistName];
    OauthAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return account;
}

// 保存用户数据
+ (void)saveOauthAccount:(OauthAccount *)account
{
    NSString *path = [[HQLSandboxUtils documentDir] stringByAppendingPathComponent:AccountPlistName];
    [NSKeyedArchiver archiveRootObject:account toFile:path];
}

@end
