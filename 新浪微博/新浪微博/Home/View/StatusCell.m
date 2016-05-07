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
#import "UIImage+Ext.h"
#import "ImageListView.h"

// 时间颜色
#define kTimeColor                  RGB(246, 165, 68)
// 会员昵称颜色
#define kMBScreenNameColor          RGB(243, 101, 18)
// 非会员昵称颜色
#define kScreenNameColor            RGB(93, 93, 93)
// 被转发微博昵称颜色
#define kReweetedScreenNameColor    RGB(63, 104, 161)

@interface StatusCell ()
{
    IconView *_iconView;                // 头像
    UILabel *_screenNameLabel;          // 昵称
    UIImageView *_mbView;                // 会员图标
    UILabel *_timeLabel;                // 时间
    UILabel *_sourceLabel;              // 来源
    UILabel *_textLabel;                // 内容
    ImageListView *_imageListView;            // 配图
    
    UIImageView *_retweetedContainer;   // 被转发微博的父控件
    UILabel *_retweetedScreenNameLabel; // 被转发微博作者的昵称
    UILabel *_retweetedTextLabel;       // 被转发微博的内容
    ImageListView *_retweetedImageListView;   // 被转发微博的配图
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
    [_timeLabel setTextColor:kTimeColor];
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
    _imageListView = [[ImageListView alloc] init];
    [self.contentView addSubview:_imageListView];
    
}

#pragma mark 添加被转发微博的子控件
- (void)addReweetedSubviews
{
    // 1.被转发微博的父控件
    _retweetedContainer = [[UIImageView alloc] init];
    [_retweetedContainer setImage:[UIImage resizedImage:@"timeline_retweet_background" xPos:0.9f yPos:0.5f]];
    [self.contentView addSubview:_retweetedContainer];
    
    // 2.被转发微博作者的昵称
    _retweetedScreenNameLabel = [[UILabel alloc] init];
    _retweetedScreenNameLabel.font = kRetweetedScreenNameFont;
    _retweetedScreenNameLabel.textColor = kReweetedScreenNameColor;
    [_retweetedContainer addSubview:_retweetedScreenNameLabel];
    
    // 3.被转发微博的内容
    _retweetedTextLabel = [[UILabel alloc] init];
    [_retweetedTextLabel setNumberOfLines:0];
    _retweetedTextLabel.font = kRetweetedTextFont;
    [_retweetedContainer addSubview:_retweetedTextLabel];
    
    // 4.被转发微博的配图
    _retweetedImageListView = [[ImageListView alloc] init];
    [_retweetedContainer addSubview:_retweetedImageListView];
    
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
    _sourceLabel.text = s.source;
    
    // 5.内容
    _textLabel.frame = statusCellFrame.textLabelFrame;
    _textLabel.text = s.text;
    
    // 6.配图
    if (s.pic_urls.count > 0) {
        _imageListView.hidden = NO;
        _imageListView.frame = statusCellFrame.imageListViewFrame;
        _imageListView.picUrls = s.pic_urls;
    } else {
        _imageListView.hidden = YES;
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
            _retweetedImageListView.hidden = NO;
            _retweetedImageListView.frame = statusCellFrame.retweetedImageListViewFrame;
            _retweetedImageListView.picUrls = s.retweeted_status.pic_urls;
        } else {
            _retweetedImageListView.hidden = YES;
        }
        
    } else {
        _retweetedContainer.hidden = YES;
    }
    
}

@end
