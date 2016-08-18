//
//  JxbNetworkConfiguation.m
//  libNetwork
//
//  Created by Peter on 16/7/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbNetworkConfiguation.h"

@implementation JxbSecurityPolicy

+ (instancetype)defaultPolicy {
    JxbSecurityPolicy* policy = [[JxbSecurityPolicy alloc] init];
    policy.policy = JxbSSLPolicy_None;
    policy.allowInvalidCertificates = NO;
    policy.validatesDomainName = YES;
    return policy;
}

@end

@implementation JxbNetworkConfiguation

+ (instancetype)defuatConfigurate {
    JxbNetworkConfiguation* config = [[JxbNetworkConfiguation alloc] init];
    config.maxRequestConcurrent = 4;
    config.sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.cacheDuration = 0;
    config.cacheMemorySize = 1024 * 1024;
    config.cacheDiskSize = 1024 * 1024 * 5;
    config.securityPolicy = [JxbSecurityPolicy defaultPolicy];
    return config;
}

@end
