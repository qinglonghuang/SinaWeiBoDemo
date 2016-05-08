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
@property (assign, nonatomic) long long ID;                         // 标识
@property (copy,   nonatomic) NSString *text;                       // 微博内容
@property (strong, nonatomic) User *user;                           // 用户
@property (strong, nonatomic) NSArray <NSDictionary *>*pic_urls;    // 微博配图
@property (strong, nonatomic) Status *retweeted_status;             // 被转发的微博
@property (copy,   nonatomic) NSString *created_at;                 // 微博创建时间
@property (assign, nonatomic) int reposts_count;                    // 转发数
@property (assign, nonatomic) int comments_count;                   // 评论数
@property (assign, nonatomic) int attitudes_count;                  // 表态数(被赞)
@property (copy,   nonatomic) NSString *source;                     // 微博来源

@end
