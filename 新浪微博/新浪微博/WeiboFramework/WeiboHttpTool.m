//
//  WeiboHttpTool.m
//  新浪微博
//
//  Created by qinglong on 16/4/24.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "WeiboHttpTool.h"
#import <AFNetworking.h>
#import "OauthAccountTool.h"

static NSString * const BaseURLStr = @"https://api.weibo.com";
static WeiboHttpTool *sharerTool = nil;

@interface WeiboHttpTool ()
{
    AFHTTPSessionManager *_httpManager;
    OauthAccount *_oauthAccount;
}

@end

@implementation WeiboHttpTool

+ (instancetype)shareTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharerTool = [[WeiboHttpTool alloc] init];
    });
    
    return sharerTool;
}

- (instancetype)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharerTool = [super init];
        NSURL *baseURL = [NSURL URLWithString:BaseURLStr];
        _httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        _httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _oauthAccount = [OauthAccountTool oauthAccount];
    });
    
    return sharerTool;
}

#pragma mark POST请求
- (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id _Nullable responseObject))success
     failure:(void (^)(NSError * _Nonnull error))failure
{
    NSMutableDictionary *newDict = [self p_parametersApendAccessToken:parameters];
    [_httpManager POST:URLString
            parameters:newDict
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
    }];
}

#pragma mark GET请求
- (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id _Nullable responseObject))success
    failure:(void (^)(NSError * _Nonnull error))failure
{
    NSMutableDictionary *newDict = [self p_parametersApendAccessToken:parameters];
    [_httpManager GET:URLString
           parameters:newDict
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
    }];
}

#pragma mark - 私有方法
- (NSMutableDictionary *)p_parametersApendAccessToken:(NSDictionary *)oriDict
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:oriDict];
    if (_oauthAccount) {
        [dict setObject:_oauthAccount.access_token forKey:@"access_token"];
    }
    
    return dict;
}

@end
