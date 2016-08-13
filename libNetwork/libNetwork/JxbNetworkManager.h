//
//  JxbNetworkManager.h
//  libNetwork
//
//  Created by Peter on 16/7/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JxbNetworkBlocks.h"

typedef NS_ENUM(NSInteger, JxbNetStatus) {
    JxbNetStatusUnknown          = -1,
    JxbNetStatusNotReachable     = 0,
    JxbNetStatusReachableViaWWAN = 1,
    JxbNetStatusStatusReachableViaWiFi = 2,
};

extern NSString * _Nonnull const JxbNetworkDidChangeNotification;

@class JxbNetworkConfiguation;

@interface JxbNetworkManager : NSObject

/**
 *  网络状态
 */
@property (nonatomic, assign, readonly) JxbNetStatus       netStatus;

/**
 *  网络是否可用
 */
@property (nonatomic, assign, readonly) BOOL               isReachable;

/**
 *  网络变化回调
 */
@property (nonatomic, copy  ) void (^ _Nullable netStatusBlock) (JxbNetStatus status);

/**
 *  网络请求配置
 */
@property (nonatomic, strong) JxbNetworkConfiguation    * _Nonnull defaultConfig;


/**
 *  单例
 *
 *  @return
 */
+ (instancetype _Nonnull)sharedInstance;

/**
 *  监控网络
 */
- (void)startMonitor;

/**
 *  停止监控
 */
- (void)stopMonitor;

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

/**
 *  Post上传文件
 *
 *  @param url            接口地址或名称
 *  @param parasDict      接口请求入参
 *  @param data           文件data
 *  @param mimeType       mineType
 *  @param fileName       文件名称
 *  @param uploadProgress 上传进度
 *  @param success        接口请求返回
 *  @param failure        接口请求错误
 */
- (NSURLSessionDataTask * _Nonnull)POST:(NSString * _Nonnull)url
                                  paras:(NSDictionary * _Nonnull)parasDict
                             uploadData:(NSData * _Nonnull)data
                               mimeType:(NSString * _Nonnull)mimeType
                               fileName:(NSString * _Nonnull)fileName
                               progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                success:(JxbNetworkResponse _Nonnull)success
                                failure:(void (^ _Nullable)(NSError * _Nonnull error))failure;
@end
