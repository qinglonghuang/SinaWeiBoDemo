//
//  IconView.h
//  新浪微博
//
//  Created by qinglong on 16/5/2.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

typedef NS_ENUM(NSInteger, IconType) {
    kIconTypeSmall = 0,
    kIconTypeDefault,
    kIconTypeBig,
};

@interface IconView : UIView

// 用户信息
@property (strong, nonatomic, readonly) User *user;
// 图标类型
@property (assign, nonatomic, readonly) IconType type;

- (void)setUser:(User *)user iconType:(IconType)type;

+ (CGSize)sizeWithType:(IconType)type;

@end
