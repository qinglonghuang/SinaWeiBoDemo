//
//  HQLSandboxUtils.m
//  新浪微博
//
//  Created by qinglong on 16/4/17.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "HQLSandboxUtils.h"

@implementation HQLSandboxUtils

#pragma mark 文档目录
+ (NSString *)documentDir
{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return documents.firstObject;
}

#pragma mark 缓存目录
+ (NSString *)cacheDir
{
    NSArray *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return caches.firstObject;
}

#pragma mark 临时目录
+ (NSString *)tempDir
{
    return NSTemporaryDirectory();
}

#pragma mark 应用程序主目录
+ (NSString *)homeDir
{
    return NSHomeDirectory();
}

#pragma mark 偏好设置
+ (void)savePreferData:(id)data forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
}

+ (id)preferDataForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
