//
//  StatusTool.m
//  新浪微博
//
//  Created by qinglong on 16/4/24.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "StatusTool.h"
#import "WeiboHttpTool.h"
#import "NSObject+JMSerializer.h"

@implementation StatusTool

+ (void)statusesWithSuccess:(StatusSuccessBlock)success failure:(StatusFailBlock)failure
{
    [[WeiboHttpTool shareTool] GET:@"2/statuses/home_timeline.json" parameters:nil
             success:^(id  _Nullable responseObject) {
                 NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                          options:NSJSONReadingMutableLeaves
                                                                            error:nil];
                 NSArray *statusesDict = jsonDict[@"statuses"];
                 NSMutableArray *statuses = [NSMutableArray array];
                 for (NSDictionary *dict in statusesDict) {
                     Status *s = [Status objectFromDictionary:dict];
                     s.user = [User objectFromDictionary:dict[@"user"]];
                     NSDictionary *retweetedDic = dict[@"retweeted_status"];
                     if (retweetedDic) {
                         s.retweeted_status = [Status objectFromDictionary:retweetedDic];
                         s.retweeted_status.user = [User objectFromDictionary:retweetedDic[@"user"]];
                     }
                     [statuses addObject:s];
                 }
                 
                 success(statuses);
             } failure:^(NSError * _Nonnull error) {
                 failure(error);
    }];
}

@end
