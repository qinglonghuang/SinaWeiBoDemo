//
//  Status.m
//  新浪微博
//
//  Created by qinglong on 16/4/24.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "Status.h"

@implementation Status

- (NSString *)created_at
{
    // Wed May 04 23:19:41 +0800 2016
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSDate *date = [fmt dateFromString:_created_at];
    
    fmt.dateFormat = @"MM-dd HH:mm:ss";
    return [fmt stringFromDate:date];
}

- (NSString *)source
{
    NSRange beginR = [_source rangeOfString:@">"];
    NSRange endR = [_source rangeOfString:@"</"];
    if ((beginR.length > 0) && (endR.length > 0)) {
        NSRange sourceR = NSMakeRange(beginR.location + beginR.length, (endR.location - (beginR.location + beginR.length)));
        return [@"来自 " stringByAppendingString:[_source substringWithRange:sourceR]];
    } else {
        return _source;
    }
}

@end
