//
//  XBApi.m
//  XBHttpClient
//
//  Created by Peter Jin @ https://github.com/JxbSir on 15/1/30.
//  Copyright (c) 2015年 Mail:i@Jxb.name. All rights reserved.
//

#import "XBApi.h"
#import "TouchJSON/NSDictionary_JSONExtensions.h"

@interface XBApi()
{
    XBHttpClient *http_common ;
    XBHttpClient *http_json ;
    
    AFHTTPRequestOperation *optSync;
}

@end

@implementation XBApi

+ (instancetype)SharedXBApi:(AFHTTPResponseSerializer*)respone
{
    static XBApi* xb = nil;
    static dispatch_once_t once ;
    dispatch_once(&once, ^{
        xb = [[XBApi alloc] initWithRespone:respone];
    });
    return xb;
}

- (instancetype)initWithRespone:(AFHTTPResponseSerializer*)respone {
    self = [super init];
    if (self) {
        [self initialHttp:respone];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self)
    {
        [self initialHttp:nil];
    }
    return self;
}

- (void)initialHttp:(AFHTTPResponseSerializer*)respone {
    http_json = [[XBHttpClient alloc] init];
    
    AFJSONResponseSerializer* response_json = respone ? (AFJSONResponseSerializer*)respone : [[AFJSONResponseSerializer alloc] init];
    [http_json setResponseSerializer:response_json];
    
    http_common = [[XBHttpClient alloc] init];
    AFHTTPResponseSerializer* response_common = respone ? (AFHTTPResponseSerializer*)respone : [[AFHTTPResponseSerializer alloc] init];
    [http_common setResponseSerializer:response_common];
}

- (void)requestWithURL:(NSString *)url
                 paras:(NSDictionary *)parasDict
                  type:(XBHttpResponseType)type
               success:(void(^)(AFHTTPRequestOperation* operation, NSObject *resultObject))success
               failure:(void(^)(NSError *requestErr))failure
{
    if(type == XBHttpResponseType_Common)
        [http_common requestWithURL:url paras:parasDict type:type success:success failure:failure];
    else
        [http_json requestWithURL:url paras:parasDict type:type success:success failure:failure];
}

- (NSObject*)requestSyncWithURL:(NSString *)url
                     paras:(NSDictionary *)parasDict
                      type:(XBHttpResponseType)type
{
    NSMutableURLRequest *request = nil;
    AFHTTPResponseSerializer* responseSerializer = nil;
    if(type == XBHttpResponseType_Common)
    {
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        request = [requestSerializer requestWithMethod:parasDict ? @"POST" : @"GET" URLString:url parameters:parasDict error:nil];
        
        responseSerializer = [AFJSONResponseSerializer serializer];
    }
    else
    {
        AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        request = [requestSerializer requestWithMethod:parasDict ? @"POST" : @"GET" URLString:url parameters:parasDict error:nil];
        
        responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    optSync = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [optSync setResponseSerializer:responseSerializer];
    [optSync start];
    [optSync waitUntilFinished];
    if(type == XBHttpResponseType_Common)
        return optSync.responseString;
    if(type == XBHttpResponseType_Json)
    {
        NSError* error = nil;
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:optSync.responseData options:NSJSONReadingAllowFragments error:&error];
        return dic;
    }
    if(type == XBHttpResponseType_JqueryJson)
    {
        NSError* error = nil;
        NSString* result = [optSync.responseString copy];
        NSString* r = nil;
        NSRange r1 = [result rangeOfString:@"("];
        if (r1.location == 0)
        {
            r = [result substringFromIndex:1];
            r = [[r substringToIndex:r.length - 1] stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
        }
        else if(r1.length > 0)
        {
            r = [result substringFromIndex:r1.location+1];
            NSRange r2 = [r rangeOfString:@")"];
            r = [[r substringToIndex:r2.location] stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
        }
        else
        {
            r = [result stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
        }

        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:[r dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        return dic;
    }
    return nil;
}
@end
