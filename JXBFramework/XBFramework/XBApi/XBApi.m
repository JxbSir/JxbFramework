//
//  XBApi.m
//  XBHttpClient
//
//  Created by Peter on 15/1/30.
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import "XBApi.h"

@interface XBApi()
{
    XBHttpClient *http ;
}

@end

@implementation XBApi

+ (instancetype)SharedXBApi
{
    static XBApi* xb = nil;
    static dispatch_once_t once ;
    dispatch_once(&once, ^{
        xb = [[XBApi alloc] init];
    });
    return xb;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        http = [[XBHttpClient alloc] init];
        AFJSONRequestSerializer* request = [[AFJSONRequestSerializer alloc] init];
        [http setRequestSerializer:request];
    }
    return self;
}

- (void)requestWithURL:(NSString *)url
                 paras:(NSDictionary *)parasDict
                  type:(XBHttpResponseType)type
               success:(void(^)(NSObject *resultObject))success
               failure:(void(^)(NSError *requestErr))failure
{
    [http requestWithURL:url paras:parasDict type:type success:success failure:failure];
}
@end
