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
    config.cacheDuration = 0;
    config.sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    return config;
}

@end
