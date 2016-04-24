//
//  OauthAccount.h
//  新浪微博
//
//  Created by qinglong on 16/4/17.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OauthAccount : NSObject <NSCoding>

@property (copy, nonatomic) NSString *access_token;

// 单位:s
@property (copy, nonatomic) NSString *expires_in;

@property (copy, nonatomic) NSString *remind_in;

@property (copy, nonatomic) NSString *uid;

@end
