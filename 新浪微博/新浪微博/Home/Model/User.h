//
//  User.h
//  新浪微博
//
//  Created by qinglong on 16/4/24.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (copy,   nonatomic) NSString *screen_name;            // 用户昵称
@property (copy,   nonatomic) NSString *profile_image_url;      // 用户头像地址
@property (assign, nonatomic) BOOL verified;                    // 是否是微博认证用户，即加V用户
@property (assign, nonatomic) int verified_type;                // 认证类型
@property (assign, nonatomic) int mbrank;                       // 会员等级
@property (assign, nonatomic) int mbtype;                       // 会员类型

@end
