//
//  User.h
//  新浪微博
//
//  Created by qinglong on 16/4/24.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, VerifiedType) {
    kVerifiedTypeNone               = -1,
    kVerifiedTypeVip                = 0,
    kVerifiedTypeOrgEnterprice      = 2,    // 企业官方：CSDN、EOE、搜狐新闻客户端
    kVerifiedTypeOrgMedia           = 3,    // 媒体官方：程序员杂志、苹果汇
    kVerifiedTypeOrgWebsite         = 5,    // 网站官方：猫扑
    kVerifiedTypeGrassRoot          = 220,  // 微博达人
};

typedef NS_ENUM(NSInteger, MBType) {
    kMBTypeNone = 0,    // 没有
    kMBTypeNormal,      // 普通
    kMBTypeYear,        // 年费
};

@interface User : NSObject

@property (copy,   nonatomic) NSString *screen_name;            // 用户昵称
@property (copy,   nonatomic) NSString *profile_image_url;      // 用户头像地址
@property (assign, nonatomic) BOOL verified;                    // 是否是微博认证用户，即加V用户
@property (assign, nonatomic) VerifiedType verified_type;       // 认证类型
@property (assign, nonatomic) int mbrank;                       // 会员等级
@property (assign, nonatomic) MBType mbtype;                       // 会员类型

@end
