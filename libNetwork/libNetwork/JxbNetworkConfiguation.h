//
//  JxbNetworkConfiguation.h
//  libNetwork
//
//  Created by Peter on 16/7/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JxbNetworkBlocks.h"

typedef NS_ENUM(NSInteger, JxbSSLPolicy) {
    JxbSSLPolicy_None,          //不开启SSL
    JxbSSLPolicy_Oneway,        //单向验证，客户端无证书
    JxbSSLPolicy_PublicKey,     //双向验证，客户端需存放证书，只匹配publicKey是否一致
    JxbSSLPolicy_Certificate    //双向验证，客户端需存放证书，完全匹配
};

@interface JxbNetworkConfiguation : NSObject

//最大并发数，AFN最大默认是4，若为0则不触发请求
@property (nonatomic, assign) NSInteger                 maxRequestConcurrent;

//默认缓存时间，默认为0不缓存
@property (nonatomic, assign) NSTimeInterval            cacheDuration;

//url请求缓存在内存中的大小，默认1兆
@property (nonatomic, assign) double                    cacheMemorySize;

//url请求缓存在磁盘中的大小，默认5兆
@property (nonatomic, assign) double                    cacheDiskSize;

//如 http://api.xxx.com
@property (nonatomic, copy  ) NSString                  *baseURL;

//请求头
@property (nonatomic, strong) NSDictionary              *requestHeaders;

//全局参数（入参）
@property (nonatomic, strong) NSDictionary              *requestMainParams;

//session配置
@property (nonatomic, copy  ) NSURLSessionConfiguration *sessionConfig;

//全局定义api请求错误时的统一处理block
@property (nonatomic, copy  ) JxbNetworkFailure         failureBlock;

//SSL安全策略
@property (nonatomic, assign) JxbSSLPolicy              policy;

//SSL双向验证时，需要提供证书地址（本地）
@property (nonatomic, strong) NSString                  *sslCertificateFile;

/**
 *  返回默认配置
 *
 *  @return
 */
+ (instancetype)defuatConfigurate;
@end
