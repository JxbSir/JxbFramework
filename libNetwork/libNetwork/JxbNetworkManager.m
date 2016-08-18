//
//  JxbNetworkManager.m
//  libNetwork
//
//  Created by Peter on 16/7/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbNetworkManager.h"
#import "JxbNetworkConfiguation.h"

#import "AFNetworking.h"
#import "AFNetworkReachabilityManager.h"


NSString * const kStoredTime                     = @"kStoredTime";
NSString * const JxbNetworkDidChangeNotification = @"com.alamofire.networking.reachability.change";

@interface JxbNetworkManager()
@property (nonatomic, assign, readwrite) JxbNetStatus         netStatus;
@property (nonatomic, strong           ) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong           ) NSURLCache           *urlCache;
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
        
        __weak typeof (self) wSelf = self;
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            __strong typeof (wSelf) sSelf = wSelf;
            sSelf.netStatus = status;
            if (sSelf.netStatusBlock != NULL) {
                sSelf.netStatusBlock(status);
            }
        }];
    }
    return self;
}

#pragma mark - Net monitor
- (void)startMonitor {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)stopMonitor {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
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
        if (MAX(cacheDuration, _defaultConfig.cacheDuration) > 0) {
            NSData* data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            [wSelf.urlCache storeCachedResponse:[[NSCachedURLResponse alloc] initWithResponse:task.response data:data userInfo:@{kStoredTime:@([[NSDate date] timeIntervalSince1970])} storagePolicy:NSURLCacheStorageAllowed] forDataTask:task];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure != NULL) {
            failure(error);
        }
        else if (wSelf.defaultConfig.failureBlock != NULL) {
            wSelf.defaultConfig.failureBlock(error);
        }
    }];
    
    if (MAX(cacheDuration, _defaultConfig.cacheDuration) > 0) {
        [self cacheOperation:task cacheValidDurtaion:MAX(cacheDuration, _defaultConfig.cacheDuration) success:success];
    }
    
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
        if (MAX(cacheDuration, _defaultConfig.cacheDuration) > 0) {
            NSData* data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            [wSelf.urlCache storeCachedResponse:[[NSCachedURLResponse alloc] initWithResponse:task.response data:data userInfo:@{kStoredTime:@([[NSDate date] timeIntervalSince1970])} storagePolicy:NSURLCacheStorageAllowed] forDataTask:task];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       if (failure != NULL) {
           failure(error);
       }
       else if (wSelf.defaultConfig.failureBlock != NULL) {
           wSelf.defaultConfig.failureBlock(error);
       }
    }];
    
    if (MAX(cacheDuration, _defaultConfig.cacheDuration) > 0) {
        [self cacheOperation:task cacheValidDurtaion:MAX(cacheDuration, _defaultConfig.cacheDuration) success:success];
    }

    
    return task;
}

#pragma mark - Post Data
- (NSURLSessionDataTask *)POST:(NSString *)url
                         paras:(NSDictionary *)parasDict
                    uploadData:(NSData *)data
                      mimeType:(NSString *)mimeType
                      fileName:(NSString *)fileName
                      progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(JxbNetworkResponse)success
                       failure:(void (^)(NSError *error))failure {
    __weak typeof (self) wSelf = self;
    NSURLSessionDataTask* task = [self.sessionManager POST:url parameters:parasDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:mimeType];
    } progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

#pragma mark - cache
- (void)cacheOperation:(NSURLSessionDataTask*)task cacheValidDurtaion:(NSTimeInterval)cacheValidDurtaion success:(JxbNetworkResponse)success {
    __weak typeof (self) wSelf = self;
    [self.urlCache getCachedResponseForDataTask:task completionHandler:^(NSCachedURLResponse * _Nullable cachedResponse) {
        if (cachedResponse) {
            NSTimeInterval storedTime = [cachedResponse.userInfo[kStoredTime] doubleValue];
            if (storedTime > 0) {
                NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
                if (nowTime - storedTime < cacheValidDurtaion) {
                    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:cachedResponse.data options:NSJSONReadingMutableContainers error:nil];
                    if (dictionary) {
                        success(dictionary);
                    }
                }
                else {
                    [wSelf.urlCache removeCachedResponseForDataTask:task];
                }
            }
        }
    }];
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

#pragma mark - getter or setter
- (void)setDefaultConfig:(JxbNetworkConfiguation *)defaultConfig {
    _defaultConfig = defaultConfig;
    if (_sessionManager && ![defaultConfig.baseURL isEqualToString:_sessionManager.baseURL.absoluteString]) {
        _sessionManager = nil;
    }
}

- (AFHTTPSessionManager*)sessionManager {
    if (!_sessionManager) {
        _defaultConfig.sessionConfig.HTTPMaximumConnectionsPerHost = _defaultConfig.maxRequestConcurrent;
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:_defaultConfig.baseURL] sessionConfiguration:_defaultConfig.sessionConfig];
        
        _sessionManager.requestSerializer = [[AFJSONRequestSerializer alloc] init];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
       
        if (_defaultConfig.securityPolicy.policy > JxbSSLPolicy_None) {
            AFSecurityPolicy *secPolicy = nil;
            if (_defaultConfig.securityPolicy.policy == JxbSSLPolicy_Oneway) {
                secPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
            }
            else if (_defaultConfig.securityPolicy.policy == JxbSSLPolicy_PublicKey) {
                secPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey withPinnedCertificates:[AFSecurityPolicy certificatesInBundle:_defaultConfig.securityPolicy.sslCertificateFile]];
            }
            else if (_defaultConfig.securityPolicy.policy == JxbSSLPolicy_Certificate) {
                secPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[AFSecurityPolicy certificatesInBundle:_defaultConfig.securityPolicy.sslCertificateFile]];
            }

            secPolicy.allowInvalidCertificates = _defaultConfig.securityPolicy.allowInvalidCertificates;
            secPolicy.validatesDomainName = _defaultConfig.securityPolicy.validatesDomainName;
            _sessionManager.securityPolicy = secPolicy;
        }
        
        
        //处理头部参数
        if (_defaultConfig.requestHeaders && _defaultConfig.requestHeaders.count > 0) {
            for (NSString* headKey in _defaultConfig.requestHeaders.allKeys) {
                 [_sessionManager.requestSerializer setValue:_defaultConfig.requestHeaders[headKey] forHTTPHeaderField:headKey];
            }
        }
    }
    return _sessionManager;
}

- (NSURLCache*)urlCache {
    if (!_urlCache) {
        NSArray *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cacheFile = [cachePath[0] stringByAppendingPathComponent:@"url_cache"];
        _urlCache = [[NSURLCache alloc] initWithMemoryCapacity:_defaultConfig.cacheMemorySize diskCapacity:_defaultConfig.cacheDiskSize diskPath:cacheFile];
    }
    return _urlCache;
}

- (JxbNetStatus)netStatus {
    return _netStatus;
}

- (BOOL)isReachable {
    return self.netStatus == JxbNetStatusReachableViaWWAN || self.netStatus == JxbNetStatusStatusReachableViaWiFi;
}
@end
