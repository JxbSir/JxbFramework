//
//  JxbNetworkConfiguation.m
//  libNetwork
//
//  Created by Peter on 16/7/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbNetworkConfiguation.h"

@implementation JxbNetworkConfiguation

+ (instancetype)defuatConfigurate {
    JxbNetworkConfiguation* config = [[JxbNetworkConfiguation alloc] init];
    config.maxRequestConcurrent = 4;
    config.sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.cacheDuration = 0;
    config.cacheMemorySize = 1024 * 1024;
    config.cacheDiskSize = 1024 * 1024 * 5;
    return config;
}

@end
