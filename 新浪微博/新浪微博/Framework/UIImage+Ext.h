//
//  UIImage+Ext.h
//  新浪微博
//
//  Created by qinglong on 16/3/24.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ext)

/**
 *  以中心一个像素点向右拉伸图片
 *
 *  @param name 图片名
 *
 *  @return 返回拉伸后的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;

/**
 *  以指定像素点向右拉伸图片
 *
 *  @param name 图片名
 *  @param xPos 拉伸起始点的X比例
 *  @param yPos 拉伸起始点的Y比例
 *
 *  @return 返回拉伸后的图片
 */
+ (UIImage *)resizedImage:(NSString *)name xPos:(CGFloat)xPos yPos:(CGFloat)yPos;

@end
