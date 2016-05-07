//
//  ImageListView.m
//  新浪微博
//
//  Created by qinglong on 16/5/7.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "ImageListView.h"
#import "ImageItemView.h"

static const NSInteger kImageCntMax = 9;

static const CGFloat kOneW = 120.0f;
static const CGFloat kOneH = 120.0f;

static const CGFloat kMultiW = 80.0f;
static const CGFloat kMultiH = 80.0f;

static const CGFloat kMargin = 6.0f;

@interface ImageListView ()


@end

@implementation ImageListView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        for (NSInteger i = 0; i < kImageCntMax; i++) {
            ImageItemView *imageView = [[ImageItemView alloc] init];
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            [imageView setClipsToBounds:YES];
            [self addSubview:imageView];
        }
    }
    
    return self;
}

#pragma mark 设置图片
- (void)setPicUrls:(NSArray<NSDictionary *> *)picUrls
{
    _picUrls = picUrls;
    
    NSInteger count = picUrls.count;
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        ImageItemView *itemView = self.subviews[i];
        if (i >= count) {
            itemView.hidden = YES;
        } else {
            itemView.hidden = NO;
            [itemView setUrl:picUrls[i][@"thumbnail_pic"]];
            
            if (count == 1) {
                itemView.frame = CGRectMake(0, 0, kOneW, kOneH);
                continue;
            }
            
            NSInteger column = (count == 4) ? 2 : 3;
            itemView.frame = CGRectMake((i % column) * (kMultiW + kMargin), (i / column) * (kMultiH + kMargin), kMultiW, kMultiH);
        }
        
    }
}

#pragma mark 计算视图大小
+ (CGSize)sizeWithCount:(NSInteger)count
{
    CGSize size = CGSizeZero;
    if (count == 1) {
        size = CGSizeMake(kOneW, kOneH);
    } else if (count == 4) {
        size = CGSizeMake(2 * (kMultiW + kMargin), 2 * (kMultiH + kMargin));
    } else {
        NSInteger column = (count > 2) ? 3 : 2;
        NSInteger row = (count - 1) / 3 + 1;
        CGFloat w = column * (kMultiW + kMargin);
        CGFloat h = row * (kMultiH + kMargin);
        size = CGSizeMake(w, h);
    }
    
    return size;
}

@end
