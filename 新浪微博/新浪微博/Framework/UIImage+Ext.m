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
 *  以中心一个像素点拉伸图片
 *
 *  @param name 图片名
 *
 *  @return 返回拉伸后的图片
 */
+ (UIImage *)resizedImage:(NSString *)name
{
    UIImage *ori = [UIImage imageNamed:name];
    UIImage *new = [ori stretchableImageWithLeftCapWidth:(ori.size.width / 2) topCapHeight:(ori.size.height / 2)];
    
    return new;
}

@end
