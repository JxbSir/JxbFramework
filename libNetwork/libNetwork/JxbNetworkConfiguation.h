//
//  JxbNetworkConfiguation.h
//  libNetwork
//
//  Created by Peter on 16/7/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JxbNetworkBlocks.h"

@interface JxbNetworkConfiguation : NSObject

//最大并发数，AFN最大默认是4，若为0则不触发请求
@property (nonatomic, assign) NSInteger                 maxRequestConcurrent;

//默认缓存时间，默认为0不缓存
@property (nonatomic, assign) NSTimeInterval            cacheDuration;

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

/**
 *  返回默认配置
 *
 *  @return
 */
+ (instancetype)defuatConfigurate;
@end
