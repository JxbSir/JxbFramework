//
//  JxbNetworkManager.m
//  libNetwork
//
//  Created by Peter on 16/7/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbNetworkManager.h"
#import "AFNetworking.h"
#import "JxbNetworkConfiguation.h"

@interface JxbNetworkManager()
@property (nonatomic, strong) AFHTTPSessionManager  *sessionManager;
@end

@implementation JxbNetworkManager

+ (instancetype)sharedInstance {
    static JxbNetworkManager    *manager;
    static dispatch_once_t      onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JxbNetworkManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _defaultConfig = [JxbNetworkConfiguation defuatConfigurate];
    }
    return self;
}

#pragma mark - Get
- (NSURLSessionDataTask *)Get:(NSString *)url
                      success:(JxbNetworkResponse)success {
    return [self Get:url cacheDuration:0 success:success failure:nil];
}

- (NSURLSessionDataTask *)Get:(NSString *)url
                cacheDuration:(NSTimeInterval)cacheDuration
                      success:(JxbNetworkResponse)success {
    return [self Get:url cacheDuration:cacheDuration success:success failure:nil];
}

- (NSURLSessionDataTask *)Get:(NSString *)url
                      success:(JxbNetworkResponse)success
                      failure:(void(^)(NSError *requestErr))failure {
    return [self Get:url cacheDuration:0 success:success failure:failure];
}

- (NSURLSessionDataTask *)Get:(NSString *)url
                cacheDuration:(NSTimeInterval)cacheDuration
                      success:(JxbNetworkResponse)success
                      failure:(void(^)(NSError *requestErr))failure {
    __weak typeof (self) wSelf = self;
    NSURLSessionDataTask* task = [self.sessionManager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure != NULL) {
            failure(error);
        }
        else if (wSelf.defaultConfig.failureBlock != NULL) {
            wSelf.defaultConfig.failureBlock(error);
        }
    }];
    return task;
}

#pragma mark - Post
- (NSURLSessionDataTask *)Post:(NSString *)url
                         paras:(NSDictionary *)parasDict
                       success:(JxbNetworkResponse)success {
    return [self Post:url paras:parasDict cacheDuration:0 success:success];
}

- (NSURLSessionDataTask *)Post:(NSString *)url
                         paras:(NSDictionary *)parasDict
                 cacheDuration:(NSTimeInterval)cacheDuration
                       success:(JxbNetworkResponse)success {
    return [self Post:url paras:parasDict cacheDuration:cacheDuration success:success failure:nil];
}

- (NSURLSessionDataTask *)Post:(NSString *)url
                         paras:(NSDictionary *)parasDict
                 cacheDuration:(NSTimeInterval)cacheDuration
                       success:(JxbNetworkResponse)success
                       failure:(void(^)(NSError *requestErr))failure {
    __weak typeof (self) wSelf = self;
    NSURLSessionDataTask* task = [self.sessionManager POST:url parameters:[self getPostParams:parasDict] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       if (failure != NULL) {
           failure(error);
       }
       else if (wSelf.defaultConfig.failureBlock != NULL) {
           wSelf.defaultConfig.failureBlock(error);
       }
    }];
    return task;
}

#pragma mark - cancel
- (void)cancelAllRequest {
    for (NSURLSessionTask* task in self.sessionManager.tasks) {
        [task cancel];
    }
}

#pragma mark - deal with common
- (NSDictionary*)getPostParams:(NSDictionary*)dic {
    //对参数添加全局参数
    NSMutableDictionary* dicParam = [NSMutableDictionary dictionaryWithDictionary:dic];
    if (_defaultConfig.requestMainParams && _defaultConfig.requestMainParams.count > 0) {
        [dicParam addEntriesFromDictionary:_defaultConfig.requestMainParams];
    }
    return dicParam;
}

#pragma mark - lazy init
- (AFHTTPSessionManager*)sessionManager {
    if (!_sessionManager) {
        _defaultConfig.sessionConfig.HTTPMaximumConnectionsPerHost = _defaultConfig.maxRequestConcurrent;
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:_defaultConfig.baseURL] sessionConfiguration:_defaultConfig.sessionConfig];
        
        _sessionManager.requestSerializer = [[AFJSONRequestSerializer alloc] init];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html"];
        
        //处理头部参数
        if (_defaultConfig.requestHeaders && _defaultConfig.requestHeaders.count > 0) {
            for (NSString* headKey in _defaultConfig.requestHeaders.allKeys) {
                 [_sessionManager.requestSerializer setValue:_defaultConfig.requestHeaders[headKey] forHTTPHeaderField:headKey];
            }
        }
    }
    return _sessionManager;
}
@end
