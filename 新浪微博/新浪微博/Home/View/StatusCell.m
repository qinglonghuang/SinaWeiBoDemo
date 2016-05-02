//
//  StatusCell.m
//  新浪微博
//
//  Created by qinglong on 16/5/1.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "StatusCell.h"
#import <UIImageView+WebCache.h>
#import "IconView.h"
#import "Common.h"

// 会员昵称颜色
#define kMBScreenNameColor      RGB(243, 101, 18)
// 非会员昵称颜色
#define kScreenNameColor        RGB(93, 93, 93)

@interface StatusCell ()
{
    IconView *_iconView;                // 头像
    UILabel *_screenNameLabel;          // 昵称
    UIImageView *_mbView;                // 会员图标
    UILabel *_timeLabel;                // 时间
    UILabel *_sourceLabel;              // 来源
    UILabel *_textLabel;                // 内容
    UIImageView *_imageView;            // 配图
    
    UIImageView *_retweetedContainer;   // 被转发微博的父控件
    UILabel *_retweetedScreenNameLabel; // 被转发微博作者的昵称
    UILabel *_retweetedTextLabel;       // 被转发微博的内容
    UIImageView *_retweetedImageView;   // 被转发微博的配图
}
@end

@implementation StatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // 1.添加微博本身的子控件
        [self addSelfSubviews];
        
        // 2.添加被转发微博的子控件
        [self addReweetedSubviews];
    }
    
    return self;
}

#pragma mark 添加微博本身的子控件
- (void)addSelfSubviews
{
    // 1.头像
    _iconView = [[IconView alloc] init];
    [self.contentView addSubview:_iconView];
    
    // 2.昵称
    _screenNameLabel = [[UILabel alloc] init];
    _screenNameLabel.font = kScreenNameFont;
    [self.contentView addSubview:_screenNameLabel];
    
    // 会员图标
    _mbView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_membership"]];
    [self.contentView addSubview:_mbView];
    
    // 3.时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = kTimeFont;
    [self.contentView addSubview:_timeLabel];
    
    // 4.来源
    _sourceLabel = [[UILabel alloc] init];
    _sourceLabel.font = kSourceFont;
    [self.contentView addSubview:_sourceLabel];
    
    // 5.内容
    _textLabel = [[UILabel alloc] init];
    [_textLabel setNumberOfLines:0];
    _textLabel.font = kTextFont;
    [self.contentView addSubview:_textLabel];
    
    // 6.配图
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    
}

#pragma mark 添加被转发微博的子控件
- (void)addReweetedSubviews
{
    // 1.被转发微博的父控件
    _retweetedContainer = [[UIImageView alloc] init];
    [self.contentView addSubview:_retweetedContainer];
    
    // 2.被转发微博作者的昵称
    _retweetedScreenNameLabel = [[UILabel alloc] init];
    _retweetedScreenNameLabel.font = kRetweetedScreenNameFont;
    [_retweetedContainer addSubview:_retweetedScreenNameLabel];
    
    // 3.被转发微博的内容
    _retweetedTextLabel = [[UILabel alloc] init];
    [_retweetedTextLabel setNumberOfLines:0];
    _retweetedTextLabel.font = kRetweetedTextFont;
    [_retweetedContainer addSubview:_retweetedTextLabel];
    
    // 4.被转发微博的配图
    _retweetedImageView = [[UIImageView alloc] init];
    [_retweetedContainer addSubview:_retweetedImageView];
    
}

- (void)setStatusCellFrame:(StatusCellFrame *)statusCellFrame
{
    _statusCellFrame = statusCellFrame;
    Status *s = statusCellFrame.status;
    
    // 1.头像
    [_iconView setUser:statusCellFrame.status.user iconType:kIconTypeSmall];
    _iconView.frame = statusCellFrame.iconViewFrame;
    
    // 2.昵称
    _screenNameLabel.frame = statusCellFrame.screenNameLabelFrame;
    _screenNameLabel.text = s.user.screen_name;
    // 判断是不是会员
    if (s.user.mbtype == kMBTypeNone) {
        _screenNameLabel.textColor = kScreenNameColor;
        _mbView.hidden = YES;
    } else {
        _screenNameLabel.textColor = kMBScreenNameColor;
        _mbView.hidden = NO;
        _mbView.frame = statusCellFrame.mbViewFrame;
    }
    
    // 3.时间
    _timeLabel.frame = statusCellFrame.timeLabelFrame;
    _timeLabel.text = s.created_at;
    
    // 4.来源
    _sourceLabel.frame = statusCellFrame.sourceLabelFrame;
    NSRange sourceBeginR = [s.source rangeOfString:@"rel=\"nofollow\">"];
    NSRange sourceEndR = [s.source rangeOfString:@"</a>"];
    if ((sourceBeginR.length > 0) && (sourceEndR.length > 0)) {
        NSRange sourceR = NSMakeRange(sourceBeginR.location + sourceBeginR.length, (sourceEndR.location - (sourceBeginR.location + sourceBeginR.length)));
        _sourceLabel.text = [s.source substringWithRange:sourceR];
    } else {
        _sourceLabel.text = s.source;
    }
    
    // 5.内容
    _textLabel.frame = statusCellFrame.textLabelFrame;
    _textLabel.text = s.text;
    
    // 6.配图
    if (s.pic_urls.count > 0) {
        _imageView.hidden = NO;
        _imageView.frame = statusCellFrame.imageViewFrame;
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:s.pic_urls[0][@"thumbnail_pic"]]
                     placeholderImage:[UIImage imageNamed:@"tabbar_profile_selected"]
                              options:(SDWebImageLowPriority | SDWebImageRetryFailed)];
    } else {
        _imageView.hidden = YES;
    }
    
    // 7. 被转发微博
    if (s.retweeted_status) {
        _retweetedContainer.hidden = NO;
        _retweetedContainer.frame = statusCellFrame.retweetedContainerFrame;
        
        // 昵称
        _retweetedScreenNameLabel.frame = statusCellFrame.retweetedScreenNameLabelFrame;
        _retweetedScreenNameLabel.text = s.retweeted_status.user.screen_name;
        
        // 内容
        _retweetedTextLabel.frame = statusCellFrame.retweetedTextLabelFrame;
        _retweetedTextLabel.text = s.retweeted_status.text;
        
        // 配图
        if (s.retweeted_status.pic_urls.count > 0) {
            _retweetedImageView.hidden = NO;
            _retweetedImageView.frame = statusCellFrame.retweetedImageViewFrame;
            
            [_retweetedImageView sd_setImageWithURL:[NSURL URLWithString:s.retweeted_status.pic_urls[0][@"thumbnail_pic"]]
                          placeholderImage:[UIImage imageNamed:@"tabbar_profile_selected"]
                                   options:(SDWebImageLowPriority | SDWebImageRetryFailed)];
        } else {
            _retweetedImageView.hidden = YES;
        }
        
    } else {
        _retweetedContainer.hidden = YES;
    }
    
}

@end
