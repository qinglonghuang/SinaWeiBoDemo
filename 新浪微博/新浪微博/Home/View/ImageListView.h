//
//  ImageListView.h
//  新浪微博
//
//  Created by qinglong on 16/5/7.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageListView : UIView

@property (strong, nonatomic) NSArray <NSDictionary *>*picUrls;            // 微博配图

#pragma mark 计算视图大小
+ (CGSize)sizeWithCount:(NSInteger)count;

@end
