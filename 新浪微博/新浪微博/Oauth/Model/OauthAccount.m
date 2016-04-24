//
//  OauthAccount.m
//  新浪微博
//
//  Created by qinglong on 16/4/17.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "OauthAccount.h"

@implementation OauthAccount

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        _access_token = [aDecoder decodeObjectForKey:@"access_token"];
        _expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        _remind_in = [aDecoder decodeObjectForKey:@"remind_in"];
        _uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:@"access_token"];
    [aCoder encodeObject:_expires_in forKey:@"expires_in"];
    [aCoder encodeObject:_remind_in forKey:@"remind_in"];
    [aCoder encodeObject:_uid forKey:@"uid"];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"OauthAccount\naccess_token:%@ \nexpires_in:%@ \nremind_in:%@ \nuid:%@", \
            _access_token, _expires_in, _remind_in, _uid];
}

@end
