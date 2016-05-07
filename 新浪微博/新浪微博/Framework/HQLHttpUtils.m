//
//  HQLHttpUtils.m
//  新浪微博
//
//  Created by qinglong on 16/4/20.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "HQLHttpUtils.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

@implementation HQLHttpUtils

#pragma mark POST请求
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id _Nullable responseObject))success
     failure:(void (^)(NSError * _Nonnull error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:URLString
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
}

#pragma mark GET请求
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id _Nullable responseObject))success
    failure:(void (^)(NSError * _Nonnull error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:URLString
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              success(responseObject);
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              failure(error);
       }];
}

#pragma mark 下载网络图片并设置到ImageView
+ (void)downloadImageWithUrl:(NSString * _Nonnull)url
                 placeHolder:(NSString * _Nullable)place
                   imageView:(UIImageView * _Nonnull)imageView
{
    if (imageView && url) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:url]
                     placeholderImage:[UIImage imageNamed:place]
                              options:(SDWebImageLowPriority | SDWebImageRetryFailed)];
    }
}

@end
