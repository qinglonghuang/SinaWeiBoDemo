//
//  StatusCellFrame.h
//  新浪微博
//
//  Created by qinglong on 16/5/2.
//  Copyright © 2016年 qinglong. All rights reserved.
//  一个StatusCellFrame对象能描述一个StatusCell内部所有子控件的frame

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Status.h"

#define kScreenNameFont             [UIFont systemFontOfSize:17]
#define kTimeFont                   [UIFont systemFontOfSize:13]
#define kSourceFont                 kTimeFont
#define kTextFont                   [UIFont systemFontOfSize:15]

#define kRetweetedTextFont          [UIFont systemFontOfSize:16]
#define kRetweetedScreenNameFont    [UIFont systemFontOfSize:16]

@interface StatusCellFrame : NSObject

@property (strong, nonatomic) Status *status;                               // 微博内容
@property (nonatomic, readonly) CGFloat cellHeight;                         // cell的高度

@property (nonatomic, readonly) CGRect iconViewFrame;                       // 头像
@property (nonatomic, readonly) CGRect screenNameLabelFrame;                // 昵称
@property (nonatomic, readonly) CGRect mbViewFrame;                         // 会员图标
@property (nonatomic, readonly) CGRect timeLabelFrame;                      // 时间
@property (nonatomic, readonly) CGRect sourceLabelFrame;                    // 来源
@property (nonatomic, readonly) CGRect textLabelFrame;                      // 内容
@property (nonatomic, readonly) CGRect imageListViewFrame;                      // 配图

@property (nonatomic, readonly) CGRect retweetedContainerFrame;             // 被转发微博的父控件
@property (nonatomic, readonly) CGRect retweetedScreenNameLabelFrame;       // 被转发微博作者的昵称
@property (nonatomic, readonly) CGRect retweetedTextLabelFrame;             // 被转发微博的内容
@property (nonatomic, readonly) CGRect retweetedImageListViewFrame;             // 被转发微博的配图

@end
