//
//  Common.h
//  新浪微博
//
//  Created by qinglong on 16/2/23.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#ifndef Common_h
#define Common_h
#import <Masonry.h>
#import "HQLSandboxUtils.h"
#import "UIImage+Ext.h"
#import "NSObject+JMSerializer.h"
#import "HQLHttpUtils.h"
#import "WeiboHttpTool.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self

#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#endif /* Common_h */
