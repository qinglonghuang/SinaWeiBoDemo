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
 *  以中心一个像素点拉伸图片
 *
 *  @param name 图片名
 *
 *  @return 返回拉伸后的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;

@end
