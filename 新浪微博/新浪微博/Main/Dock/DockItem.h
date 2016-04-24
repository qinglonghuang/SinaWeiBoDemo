//
//  DockItem.h
//  新浪微博
//
//  Created by qinglong on 16/3/1.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DockItem : UIButton

+ (DockItem *)dockItemWithName:(NSString *)name icon:(NSString *)icon selectedIcon:(NSString *)selectedIcon;

@end
