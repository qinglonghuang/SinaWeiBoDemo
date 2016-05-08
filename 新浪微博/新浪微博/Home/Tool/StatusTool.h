//
//  StatusTool.h
//  新浪微博
//
//  Created by qinglong on 16/4/24.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Status.h"

typedef void (^StatusSuccessBlock)(NSArray <Status *> *statuses);
typedef void (^StatusFailBlock)(NSError *error);

@interface StatusTool : NSObject

/**
 *  获取状态
 *
 *  @param success 成功块代码
 *  @param failure 失败块代码
 */
+ (void)statusesWithSinceID:(long long)sinceID
                      maxID:(long long)maxID
                    success:(StatusSuccessBlock)success
                    failure:(StatusFailBlock)failure;

@end
