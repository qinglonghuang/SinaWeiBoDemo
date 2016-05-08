//
//  StatusDock.m
//  新浪微博
//
//  Created by qinglong on 16/5/8.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "StatusDock.h"
#import "Common.h"

#define kBgColor RGB(249, 249, 249)
#define kBtnCnt  3

typedef NS_ENUM(NSInteger, Tag) {
    kTagRetweet = 0,        // 转发
    kTagComment,            // 评论
    kTagUnlike,             // 赞
};

@interface StatusDock ()
{
    BOOL _isBtnFrameSetted;
}

@end

@implementation StatusDock

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = kBgColor;
        [self p_addBtnWithTitle:@"转发" image:@"timeline_icon_retweet" tag:kTagRetweet];
        [self p_addBtnWithTitle:@"评论" image:@"timeline_icon_comment" tag:kTagComment];
        [self p_addBtnWithTitle:@"赞" image:@"timeline_icon_unlike" tag:kTagUnlike];
    }
    
    return self;
}

#pragma mark 添加按钮
- (UIButton *)p_addBtnWithTitle:(NSString *)title
                          image:(NSString *)image
                          tag:(NSInteger)tag
{
    UIButton *b = [[UIButton alloc] init];
    b.tag = tag;
    [b setTitle:title forState:UIControlStateNormal];
    [b setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [b setBackgroundImage:[UIImage resizedImage:@"common_card_middle_background"]
                 forState:UIControlStateNormal];
    [b setBackgroundImage:[UIImage resizedImage:@"common_card_middle_background_highlighted"]
                 forState:UIControlStateHighlighted];
    [b setTitleColor:RGB(146, 146, 146) forState:UIControlStateNormal];
    [b setTitleColor:RGB(40, 40, 40) forState:UIControlStateHighlighted];
    [b.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    b.titleEdgeInsets = UIEdgeInsetsMake(0, 10.0f, 0, 0);
    
    [self addSubview:b];
    
    return b;
}

- (void)setFrame:(CGRect)frame
{
    if (!_isBtnFrameSetted) {
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                CGFloat w = frame.size.width / kBtnCnt;
                CGFloat h = frame.size.height;
                // 因为背景图片的设计，导致两个按钮间间隙太大，需要调整按钮宽度来减小间隙
                CGFloat adjustMargin = 3.0f;
                view.frame = CGRectMake(w * view.tag, 0, w + adjustMargin, h);
                
                _isBtnFrameSetted = YES;
            }
        }
    }
    
    [super setFrame:frame];
}

@end
