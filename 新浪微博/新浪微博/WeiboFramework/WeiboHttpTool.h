//
//  WeiboHttpTool.h
//  新浪微博
//
//  Created by qinglong on 16/4/24.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboHttpTool : NSObject

+ (instancetype _Nullable)shareTool;

/**
 *  POST请求
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param success    成功block
 *  @param failure    失败block
 */
- (void)POST:(NSString * _Nonnull)URLString
  parameters:(id _Nullable)parameters
     success:(void (^ _Nullable)(id  _Nullable responseObject))success
     failure:(void (^ _Nullable)(NSError * _Nonnull error))failure;

/**
 *  GET请求
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param success    成功block
 *  @param failure    失败block
 */
- (void)GET:(NSString * _Nonnull)URLString
 parameters:(id _Nullable)parameters
    success:(void (^ _Nullable)(id _Nullable responseObject))success
    failure:(void (^ _Nullable)(NSError * _Nonnull error))failure;

@end
