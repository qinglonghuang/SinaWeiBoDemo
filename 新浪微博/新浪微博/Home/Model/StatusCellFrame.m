//
//  StatusCellFrame.m
//  新浪微博
//
//  Created by qinglong on 16/5/2.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "StatusCellFrame.h"
#import "IconView.h"
#import "ImageListView.h"

#define kMBIconW    14.0f
#define kMBIconH    14.0f

static const CGFloat kCellBorderOffset = 10.0f;

@implementation StatusCellFrame

- (void)setStatus:(Status *)status
{
    _status = status;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    // 利用微博数据，计算所有子控件的frame
    // 1.头像
    CGFloat iconX = kCellBorderOffset;
    CGFloat iconY = kCellBorderOffset;
    CGSize iconSize = [IconView sizeWithType:kIconTypeSmall];
    _iconViewFrame = CGRectMake(iconX, iconY, iconSize.width, iconSize.height);
    
    // 2.昵称
    CGFloat screenNameX = CGRectGetMaxX(_iconViewFrame) + kCellBorderOffset;
    CGFloat screenNameY = iconY;
    CGSize screenNameSize = [status.user.screen_name boundingRectWithSize:CGSizeMake(cellW - screenNameX, MAXFLOAT)
                                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                                               attributes:@{NSFontAttributeName:kScreenNameFont}
                                                                  context:nil].size;
    _screenNameLabelFrame = (CGRect){{screenNameX, screenNameY}, screenNameSize};
    
    // 会员图标
    if (status.user.mbtype != kMBTypeNone) {
        CGFloat mbViewX = CGRectGetMaxX(_screenNameLabelFrame) + kCellBorderOffset;
        CGFloat mbViewY = screenNameY + (screenNameSize.height - kMBIconH) * 0.5f;
        _mbViewFrame = CGRectMake(mbViewX, mbViewY, kMBIconW, kMBIconH);
    }
    
    // 3.时间
    CGFloat timeX = screenNameX;
    CGFloat timeY = CGRectGetMaxY(_screenNameLabelFrame) + kCellBorderOffset;
    CGSize timeSize = [status.created_at boundingRectWithSize:CGSizeMake((cellW - timeX) / 2, MAXFLOAT)
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:@{NSFontAttributeName:kTimeFont}
                                                            context:nil].size;
    _timeLabelFrame = (CGRect){{timeX, timeY}, timeSize};
    
    // 4.来源
    CGFloat sourceX = CGRectGetMaxX(_timeLabelFrame) + kCellBorderOffset;
    CGFloat sourceY = timeY;
    _sourceLabelFrame = (CGRect){{sourceX, sourceY}, (cellW - sourceX - kCellBorderOffset), kSourceFont.lineHeight};
    
    // 5.内容
    CGFloat textX = iconX;
    CGFloat maxY = MAX(CGRectGetMaxY(_sourceLabelFrame), CGRectGetMaxY(_iconViewFrame));
    CGFloat textY = maxY + kCellBorderOffset;
    CGSize textSize = [status.text boundingRectWithSize:CGSizeMake((cellW - 2 * kCellBorderOffset), MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:kTextFont}
                                                context:nil].size;
    _textLabelFrame = (CGRect){{textX, textY}, textSize};
    
    if (status.pic_urls.count > 0) {
        // 6.配图
        CGFloat imageX = textX;
        CGFloat imageY = CGRectGetMaxY(_textLabelFrame) + kCellBorderOffset;
        CGSize size = [ImageListView sizeWithCount:status.pic_urls.count];
        _imageListViewFrame = CGRectMake(imageX, imageY, size.width, size.height);
    } else if (status.retweeted_status) {
        // 7.有转发的微博
        // 被转发微博父控件
        CGFloat retweetedContainerX = textX;
        CGFloat retweetedContainerY = CGRectGetMaxY(_textLabelFrame) + kCellBorderOffset;
        CGFloat retweetedContainerW = cellW - 2 * kCellBorderOffset;
        CGFloat retweetedContainerH = kCellBorderOffset;
        
        // 7.1 被转发微博的昵称
        CGFloat retweetedScreenNameX = kCellBorderOffset;
        CGFloat retweetedScreenNameY = kCellBorderOffset;
        CGSize retweetedScreenNameSize = [status.retweeted_status.user.screen_name boundingRectWithSize:CGSizeMake((retweetedContainerW - 2 * kCellBorderOffset), MAXFLOAT)
                                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                                attributes:@{NSFontAttributeName:kRetweetedScreenNameFont}
                                                                   context:nil].size;
        _retweetedScreenNameLabelFrame = (CGRect){{retweetedScreenNameX, retweetedScreenNameY}, retweetedScreenNameSize};
        
        // 7.2 被转发微博的内容
        CGFloat retweetedTextX = retweetedScreenNameX;
        CGFloat retweetedTextY = CGRectGetMaxY(_retweetedScreenNameLabelFrame) + kCellBorderOffset;
        CGSize retweetedTextSize = [status.retweeted_status.text boundingRectWithSize:CGSizeMake((retweetedContainerW - 2 * kCellBorderOffset), MAXFLOAT)
                                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                                attributes:@{NSFontAttributeName:kRetweetedTextFont}
                                                                   context:nil].size;
        _retweetedTextLabelFrame = (CGRect){{retweetedTextX, retweetedTextY}, retweetedTextSize};
        
        // 7.3 被转发微博的配图
        if (status.retweeted_status.pic_urls.count > 0) {
            CGFloat retweetedImageX = retweetedTextX;
            CGFloat retweetedImageY = CGRectGetMaxY(_retweetedTextLabelFrame) + kCellBorderOffset;
            CGSize size = [ImageListView sizeWithCount:status.retweeted_status.pic_urls.count];
            _retweetedImageListViewFrame = CGRectMake(retweetedImageX, retweetedImageY, size.width, size.height);
            retweetedContainerH += CGRectGetMaxY(_retweetedImageListViewFrame);
        } else {
            retweetedContainerH += CGRectGetMaxY(_retweetedTextLabelFrame);
        }
        
        // 7.4 被转发微博父控件
        _retweetedContainerFrame = CGRectMake(retweetedContainerX, retweetedContainerY, retweetedContainerW, retweetedContainerH);
    }
    
    // 8.整个cell的高度
    _cellHeight = kCellBorderOffset;
    if (status.pic_urls.count > 0) {
        _cellHeight += CGRectGetMaxY(_imageListViewFrame);
    } else if (status.retweeted_status) {
        _cellHeight += CGRectGetMaxY(_retweetedContainerFrame);
    } else {
        _cellHeight += CGRectGetMaxY(_textLabelFrame);
    }

}

@end
