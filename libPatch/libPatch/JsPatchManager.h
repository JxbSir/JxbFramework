//
//  JsPatchManager.h
//  JsPatch
//
//  Created by Peter on 16/7/20.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JsPatchDelegate <NSObject>

@optional
/**
 *  下载回调协议（optional）
 *
 *  @param process      下载进度，可以自定义UI实现
 */
- (void)jsPathDownload:(double)process;
@end

@interface JsPatchManager : NSObject

#pragma mark - 使用JsPatch官方补丁逻辑
/**
 *  启动JsPatch
 *
 *  @param appKey appkey
 */
+ (void)startPatch:(NSString* _Nonnull)appKey;

/**
 *  启动JsPatch
 *
 *  @param appKey    appkey
 *  @param publicKey Rsa公钥
 */
+ (void)startPatch:(NSString* _Nonnull)appKey publicKey:(NSString* _Nullable)publicKey;

/**
 *  启动JsPatch
 *
 *  @param appKey       appkey
 *  @param publicKey    Rsa公钥
 *  @param bDevelopment 是否启用开发模式下发
 */
+ (void)startPatch:(NSString* _Nonnull)appKey publicKey:(NSString* _Nullable)publicKey bDevelopment:(BOOL)bDevelopment;

/**
 *  启动JsPatch
 *
 *  @param appKey       appkey
 *  @param publicKey    Rsa公钥
 *  @param bDevelopment 是否启用开发模式下发
 *  @param bTest        是否使用main.js测试
 */
+ (void)startPatch:(NSString* _Nonnull)appKey publicKey:(NSString* _Nullable)publicKey bDevelopment:(BOOL)bDevelopment bTest:(BOOL)bTest;

#pragma mark - 自己实现下载执行逻辑
//代理
@property (nonatomic, weak) id<JsPatchDelegate> _Nullable delegate;

/**
 *  单例
 *
 *  @return             JsPatchManager
 */
+ (instancetype _Nonnull)shareInstance;

/**
 *  通过网络下载JsPatch包
 *
 *  @param urls         NSURL数组
 */
- (void)downloadJsPatch:(NSArray* _Nonnull)urls;

/**
 *  执行Jspatch代码
 *
 *  @param jsContent    NSString数组
 */
- (void)excuteJsPatch:(NSArray* _Nonnull)jsContents;
@end
