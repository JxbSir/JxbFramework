//
//  JxbNetworkManager.h
//  libNetwork
//
//  Created by Peter on 16/7/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JxbNetworkBlocks.h"

@class JxbNetworkConfiguation;

@interface JxbNetworkManager : NSObject

@property (nonatomic, strong) JxbNetworkConfiguation    * _Nonnull defaultConfig;

/**
 *  单例
 *
 *  @return
 */
+ (instancetype _Nonnull)sharedInstance;

/**
 *  取消正在执行的所有请求
 */
- (void)cancelAllRequest;

/**
 *  Get请求
 *
 *  @param url     url（接口名称）
 *  @param success 返回block
 */
- (NSURLSessionDataTask  * _Nonnull)Get:(NSString * _Nonnull)url
                      success:(JxbNetworkResponse _Nonnull)success;

/**
 *  Get请求
 *
 *  @param url           接口地址或名称
 *  @param cacheDuration 缓存时间
 *  @param success       接口请求返回
 */
- (NSURLSessionDataTask * _Nonnull)Get:(NSString * _Nonnull)url
                cacheDuration:(NSTimeInterval)cacheDuration
                      success:(JxbNetworkResponse _Nonnull)success;

/**
 *  Get请求
 *
 *  @param url     接口地址或名称
 *  @param success 接口请求返回
 *  @param failure 接口请求错误
 */
- (NSURLSessionDataTask * _Nonnull)Get:(NSString * _Nonnull)url
                      success:(JxbNetworkResponse _Nonnull)success
                      failure:(void(^ _Nonnull)(NSError * _Nonnull requestErr))failure;

/**
 *  Get请求
 *
 *  @param url           接口地址或名称
 *  @param cacheDuration 缓存时间
 *  @param success       接口请求返回
 *  @param failure       接口请求错误
 */
- (NSURLSessionDataTask * _Nonnull)Get:(NSString * _Nonnull)url
                cacheDuration:(NSTimeInterval)cacheDuration
                      success:(JxbNetworkResponse _Nonnull)success
                      failure:(void(^ _Nullable)(NSError * _Nonnull requestErr))failure;

/**
 *  Post请求
 *
 *  @param url       接口地址或名称
 *  @param parasDict 接口请求入参
 *  @param success   接口请求返回
 */
- (NSURLSessionDataTask * _Nonnull)Post:(NSString * _Nonnull)url
                         paras:(NSDictionary * _Nonnull)parasDict
                       success:(JxbNetworkResponse _Nonnull)success;

/**
 *   Post请求
 *
 *  @param url           接口地址或名称
 *  @param parasDict     接口请求入参
 *  @param cacheDuration 缓存时间
 *  @param success       接口请求返回
 */
- (NSURLSessionDataTask * _Nonnull)Post:(NSString * _Nonnull)url
                         paras:(NSDictionary * _Nonnull)parasDict
                 cacheDuration:(NSTimeInterval)cacheDuration
                       success:(JxbNetworkResponse _Nonnull)success;

/**
 *   Post请求
 *
 *  @param url           接口地址或名称
 *  @param parasDict     接口请求入参
 *  @param cacheDuration 缓存时间
 *  @param success       接口请求返回
 *  @param failure       接口请求错误
 */
- (NSURLSessionDataTask * _Nonnull)Post:(NSString * _Nonnull)url
                         paras:(NSDictionary * _Nonnull)parasDict
                 cacheDuration:(NSTimeInterval)cacheDuration
                       success:(JxbNetworkResponse _Nonnull)success
                       failure:(void(^ _Nullable)(NSError  * _Nonnull requestErr))failure;
@end
