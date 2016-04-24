//
//  DockItem.m
//  新浪微博
//
//  Created by qinglong on 16/3/1.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "DockItem.h"

#define kImageHeightRatio    0.55f

@implementation DockItem

+ (DockItem *)dockItemWithName:(NSString *)name icon:(NSString *)icon selectedIcon:(NSString *)selectedIcon
{
    DockItem *item = [[DockItem alloc] init];
    [item setTitle:name forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateSelected];
    [item setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
    [item.imageView setContentMode:UIViewContentModeCenter];
    [item.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [item.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    
    return item;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * kImageHeightRatio;
    
    return CGRectMake(0, 0, w, h);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat y = contentRect.size.height * kImageHeightRatio; // image的高度值就是Y值
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * (1 - kImageHeightRatio);
    
    return CGRectMake(0, y, w, h);
}

@end
