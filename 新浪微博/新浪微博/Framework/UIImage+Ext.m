//
//  UIImage+Ext.m
//  新浪微博
//
//  Created by qinglong on 16/3/24.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "UIImage+Ext.h"

@implementation UIImage (Ext)

#pragma mark 以中心一个像素点拉伸图片
/**
 *  以中心一个像素点向右拉伸图片
 *
 *  @param name 图片名
 *
 *  @return 返回拉伸后的图片
 */
+ (UIImage *)resizedImage:(NSString *)name
{
    return [UIImage resizedImage:name xPos:0.5f yPos:0.5f];
}

/**
 *  以指定像素点向右拉伸图片
 *
 *  @param name 图片名
 *  @param xPos 拉伸起始点的X比例 (0.0 - 1.0f)
 *  @param yPos 拉伸起始点的Y比例 (0.0 - 1.0f)
 *
 *  @return 返回拉伸后的图片
 */
+ (UIImage *)resizedImage:(NSString *)name xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *ori = [UIImage imageNamed:name];
    UIImage *new = [ori stretchableImageWithLeftCapWidth:(ori.size.width * xPos) topCapHeight:(ori.size.height * yPos)];
    
    return new;
}

@end
