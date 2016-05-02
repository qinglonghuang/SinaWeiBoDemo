//
//  IconView.m
//  新浪微博
//
//  Created by qinglong on 16/5/2.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "IconView.h"
#import <UIImageView+WebCache.h>

#define kIconSmallW     34.0f
#define kIconsmallH     34.0f

#define kIconDefaultW   50.0f
#define kIconDefaultH   50.0f

#define kIconBigW       85.0f
#define kIconBigH       85.0f

#define kVerifyW        18.0f
#define kVerifyH        18.0f

@interface IconView ()
{
    // 用户头像
    UIImageView *_profileView;
    // 右下角的认证图标
    UIImageView *_verifyView;
}

@end

@implementation IconView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // 1.用户头像图片
        _profileView = [[UIImageView alloc] init];
        [self addSubview:_profileView];
        
        // 2.右下角的认证图标
        _verifyView = [[UIImageView alloc] init];
        [self addSubview:_verifyView];
    }
    
    return self;
}

#pragma mark 设置用户和类型(但是设置顺序要严格按照先设置类型再设置用户)
- (void)setUser:(User *)user iconType:(IconType)type
{
    // 1.设置类型
    [self setType:type];
    // 2.设置用户
    [self setUser:user];
}

- (void)setUser:(User *)user
{
    _user = user;
    
    // 1.设置用户头像图片
    [_profileView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url]
                    placeholderImage:[UIImage imageNamed:@"tabbar_profile_selected"]
                             options:(SDWebImageRetryFailed | SDWebImageLowPriority)];
    
    // 2.设置认证图标
    NSString *verifyIconName = nil;
    switch (user.verified_type) {
        case kVerifiedTypeNone:
            _verifyView.hidden = YES;
            break;
        case kVerifiedTypeVip:
            verifyIconName = @"avatar_vip";
            break;
        case kVerifiedTypeGrassRoot: // 微博达人
            verifyIconName = @"avatar_grassroot";
            break;
        default: // 企业认证
            verifyIconName = @"avatar_enterprise_vip";
            break;
    }
    
    // 3.如果有认证，显示图标
    if (verifyIconName) {
        _verifyView.hidden = NO;
        _verifyView.image = [UIImage imageNamed:verifyIconName];
    }
}

- (void)setType:(IconType)type
{
    _type = type;
    
    // 1.判断类型
    CGSize iconSize = CGSizeZero;
    switch (type) {
        case kIconTypeSmall:
            iconSize = CGSizeMake(kIconSmallW, kIconsmallH);
            break;
        case kIconTypeDefault:
            iconSize = CGSizeMake(kIconDefaultW, kIconDefaultH);
            break;
        case kIconTypeBig:
            iconSize = CGSizeMake(kIconBigW, kIconBigH);
            break;
    }
    
    // 2.设置frame
    _profileView.frame = (CGRect){CGPointZero, iconSize};
    _verifyView.bounds = CGRectMake(0, 0, kVerifyW, kVerifyW);
    _verifyView.center = CGPointMake(iconSize.width, iconSize.height);
}

+ (CGSize)sizeWithType:(IconType)type
{
    // 1.判断类型
    CGSize iconSize = CGSizeZero;
    switch (type) {
        case kIconTypeSmall:
            iconSize = CGSizeMake(kIconSmallW, kIconsmallH);
            break;
        case kIconTypeDefault:
            iconSize = CGSizeMake(kIconDefaultW, kIconDefaultH);
            break;
        case kIconTypeBig:
            iconSize = CGSizeMake(kIconBigW, kIconBigH);
            break;
    }
    
    // 2.IconView的宽高
    CGFloat width = iconSize.width + kVerifyW * 0.5f;
    CGFloat height = iconSize.height + kVerifyH * 0.5f;
    
    return CGSizeMake(width, height);
}

@end
