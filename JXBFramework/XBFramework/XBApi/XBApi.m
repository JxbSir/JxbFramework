//
//  XBApi.m
//  XBHttpClient
//
//  Created by Peter Jin @ https://github.com/JxbSir on 15/1/30.
//  Copyright (c) 2015年 Mail:i@Jxb.name. All rights reserved.
//

#import "XBApi.h"
#import "TouchJSON/NSDictionary_JSONExtensions.h"


static XBApi* xb = nil;
static dispatch_once_t once;

@interface XBApi()
@property (nonatomic, strong) XBHttpClient *http_common ;
@property (nonatomic, strong) XBHttpClient *http_json ;
@end

@implementation XBApi

+ (instancetype)SharedXBApi:(AFHTTPRequestSerializer*)request respone:(AFHTTPResponseSerializer*)respone {
    dispatch_once(&once, ^{
        xb = [[XBApi alloc] initWithRespone:request response:respone];
    });
    return xb;
}

+ (instancetype)SharedXBApi {
    dispatch_once(&once, ^{
        xb = [[XBApi alloc] init];
    });
    return xb;
}

- (instancetype)initWithRespone:(AFHTTPRequestSerializer*)request response:(AFHTTPResponseSerializer*)response {
    self = [super init];
    if (self) {
        [self initialHttp:request respone:response];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self)
    {
        [self initialHttp:nil respone:nil];
    }
    return self;
}

- (void)initialHttp:(AFHTTPRequestSerializer*)request respone:(AFHTTPResponseSerializer*)respone {
    self.http_json = [[XBHttpClient alloc] init];
    
    AFJSONRequestSerializer* request_json = request ? (AFJSONRequestSerializer*)request : [[AFJSONRequestSerializer alloc] init];
    [self.http_json setRequestSerializer:request_json];
    
    AFJSONResponseSerializer* response_json = respone ? (AFJSONResponseSerializer*)respone : [[AFJSONResponseSerializer alloc] init];
    [self.http_json setResponseSerializer:response_json];
    
    
    
    self.http_common = [[XBHttpClient alloc] init];
    
    AFHTTPRequestSerializer* request_common = request ? (AFHTTPRequestSerializer*)request : [[AFHTTPRequestSerializer alloc] init];
    [self.http_common setRequestSerializer:request_common];
    
    AFHTTPResponseSerializer* response_common = respone ? (AFHTTPResponseSerializer*)respone : [[AFHTTPResponseSerializer alloc] init];
    [self.http_common setResponseSerializer:response_common];
}

- (void)requestWithURL:(NSString *)url
                 paras:(NSDictionary *)parasDict
                  type:(XBHttpResponseType)type
               success:(void(^)(NSURLSessionDataTask* task, NSObject *resultObject))success
               failure:(void(^)(NSError *requestErr))failure
{
    if(type == XBHttpResponseType_Common)
        [self.http_common requestWithURL:url paras:parasDict type:type success:success failure:failure];
    else
        [self.http_json requestWithURL:url paras:parasDict type:type success:success failure:failure];
}
@end
