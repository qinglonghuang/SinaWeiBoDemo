//
//  Dock.h
//  新浪微博
//
//  Created by qinglong on 16/3/1.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DockDelegate;
@interface Dock : UIView

@property (weak, nonatomic) id<DockDelegate> delegate;

- (void)addDockItem:(NSString *)name icon:(NSString *)icon selectedIcon:(NSString *)selectedIcon;

@end

@protocol DockDelegate <NSObject>

@optional
- (void)dock:(Dock *)dock didSelectedFrom:(NSInteger)from to:(NSInteger)to;

@end


