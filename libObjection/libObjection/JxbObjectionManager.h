//
//  JxbObjectionManager.h
//  libObjection
//
//  Created by Peter on 16/7/31.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JxbObjectionManager : NSObject

/**
 *  单例
 *
 *  @return JxbObjectionManager
 */
+ (instancetype _Nonnull)shareInstance;

/**
 *  绑定实例到协议
 *
 *  @param obj        实例对象
 *  @param toProtocol 协议
 */
- (void)bindInstance:(id _Nonnull)obj toProtocol:(Protocol * _Nonnull)toProtocol;

/**
 *  绑定实例到协议
 *
 *  @param obj        实例对象
 *  @param toProtocol 协议
 *  @param forName    名称
 */
- (void)bindInstance:(id _Nonnull)obj toProtocol:(Protocol * _Nonnull)toProtocol forName:(NSString * _Nullable)forName;

/**
 *  绑定类到协议
 *
 *  @param cls        类
 *  @param toProtocol 协议
 */
- (void)bindClass:(Class _Nonnull)cls toProtocol:(Protocol * _Nonnull)toProtocol;

/**
 *  绑定类到协议
 *
 *  @param cls        类
 *  @param toProtocol 协议
 *  @param forName    名称
 */
- (void)bindClass:(Class _Nonnull)cls toProtocol:(Protocol * _Nonnull)toProtocol forName:(NSString * _Nullable)forName;

/**
 *  通过协议获取实例或类
 *
 *  @param fromProtocol 协议
 *
 *  @return 实例或类
 */
- (id _Nullable)getObject:(Protocol * _Nonnull)fromProtocol;

/**
 *  通过协议与名称获取实例或类
 *
 *  @param fromProtocol 协议
 *  @param forName      名称
 *
 *  @return 实例或类
 */
- (id _Nullable)getObject:(Protocol * _Nonnull)fromProtocol orName:(NSString * _Nullable)forName;
@end
