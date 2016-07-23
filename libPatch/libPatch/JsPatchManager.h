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
+ (void)startPatch:(NSString*)appKey;
+ (void)startPatch:(NSString*)appKey publicKey:(NSString*)publicKey;
+ (void)startPatch:(NSString*)appKey publicKey:(NSString*)publicKey bDevelopment:(BOOL)bDevelopment;

#pragma mark - 自己实现下载执行逻辑
//代理
@property (nonatomic, weak) id<JsPatchDelegate>    delegate;

/**
 *  单例
 *
 *  @return             JsPatchManager
 */
+ (instancetype)shareInstance;

/**
 *  通过网络下载JsPatch包
 *
 *  @param urls         NSURL数组
 */
- (void)downloadJsPatch:(NSArray*)urls;

/**
 *  执行Jspatch代码
 *
 *  @param jsContent    NSString数组
 */
- (void)excuteJsPatch:(NSArray*)jsContents;
@end
