//
//  HQLHttpUtils.h
//  新浪微博
//
//  Created by qinglong on 16/4/20.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HQLHttpUtils : NSObject

/**
 *  POST请求
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param success    成功block
 *  @param failure    失败block
 */
+ (void)POST:(NSString * _Nonnull)URLString
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
+ (void)GET:(NSString * _Nonnull)URLString
 parameters:(id _Nullable)parameters
    success:(void (^ _Nullable)(id _Nullable responseObject))success
    failure:(void (^ _Nullable)(NSError * _Nonnull error))failure;

/**
 *  下载网络图片并设置到ImageView
 *
 *  @param url       图片链接
 *  @param place     占位图片
 *  @param imageView 图片显示视图
 */
+ (void)downloadImageWithUrl:(NSString * _Nonnull)url
                 placeHolder:(NSString * _Nullable)place
                   imageView:(UIImageView * _Nonnull)imageView;
@end
