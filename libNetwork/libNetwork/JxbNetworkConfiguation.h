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

@interface JxbSecurityPolicy : NSObject

/**
 *  SSL安全策略模式(默认不开启SSL)
 */
@property (nonatomic, assign) JxbSSLPolicy              policy;

/**
 *  SSL双向验证时，需要提供证书地址（本地）
 */
@property (nonatomic, strong) NSBundle                  *sslCertificateFile;

/**
 *  allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
 *  如果是需要验证自建证书，需要设置为YES
 */
@property (nonatomic, assign) BOOL                      allowInvalidCertificates;

/**
 *  validatesDomainName 是否需要验证域名，默认为YES；
 *  假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
 *  置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
 *  如置为NO，建议自己添加对应域名的校验逻辑。
 */
@property (nonatomic, assign) BOOL                      validatesDomainName;

/**
 *  默认策略
 *
 *  @return 
 */
+ (instancetype)defaultPolicy;
@end

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

@property (nonatomic, strong) JxbSecurityPolicy         *securityPolicy;

/**
 *  返回默认配置
 *
 *  @return
 */
+ (instancetype)defuatConfigurate;
@end
