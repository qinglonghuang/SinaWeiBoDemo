//
//  ImageItemView.m
//  新浪微博
//
//  Created by qinglong on 16/5/7.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "ImageItemView.h"
#import "HQLHttpUtils.h"
#import <Masonry.h>
#import "Common.h"

@interface ImageItemView ()
{
    UIImageView *_gifView;
}

@end

@implementation ImageItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        UIImage *gifImg = [UIImage imageNamed:@"timeline_image_gif"];
        _gifView = [[UIImageView alloc] initWithImage:gifImg];
        _gifView.hidden = YES;
        [self addSubview:_gifView];
        WS(weakSelf);
        [_gifView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.trailing.equalTo(weakSelf);
        }];
    }
    
    return self;
}

- (void)setUrl:(NSString *)url
{
    _url = url;
    [HQLHttpUtils downloadImageWithUrl:url placeHolder:@"tabbar_profile_selected" imageView:self];
    
    _gifView.hidden = ![url.lowercaseString hasSuffix:@"gif"];
}

@end
