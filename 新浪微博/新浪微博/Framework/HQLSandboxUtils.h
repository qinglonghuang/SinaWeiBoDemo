//
//  HQLSandboxUtils.h
//  新浪微博
//
//  Created by qinglong on 16/4/17.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQLSandboxUtils : NSObject

/**
 *  文档目录
 *
 *  @return 文档目录
 */
+ (NSString *)documentDir;

/**
 *  缓存目录
 *
 *  @return 缓存目录
 */
+ (NSString *)cacheDir;

/**
 *  临时目录
 *
 *  @return 临时目录
 */
+ (NSString *)tempDir;

/**
 *  应用程序主目录
 *
 *  @return 应用程序主目录
 */
+ (NSString *)homeDir;

/**
 *  设置偏好设置
 *
 *  @param data 数据
 *  @param key  标识
 */
+ (void)savePreferData:(id)data forKey:(NSString *)key;

/**
 *  读取偏好设置
 *
 *  @param key 标识
 *
 *  @return 数据
 */
+ (id)preferDataForKey:(NSString *)key;

@end
