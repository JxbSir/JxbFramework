//
//  libRouterManager.h
//  libRouter
//
//  Created by Peter on 16/7/22.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface libRouterManager : NSObject

/**
 *  注册一个通用解耦的导航控制器Push
 *
 *  @param appSchema    App的主Schema
 */
+ (void)registerCommonPush:(NSString*)appSchema;

/**
 *  注册Schema Url功能
 *
 *  @param schemaUrl    schemaUrl
 *  @param toHandler    参数回调block
 */
+ (void)regiserUrl:(NSString*)schemaUrl toHandler:(void(^)(NSDictionary* parameters))toHandler;

/**
 *  打开URL，可以前往各个业务模块
 *
 *  @param url          schema url
 *
 *  @return 是否能够前往
 */
+ (BOOL)openUrl:(NSURL*)url;

/**
 *  打开URL，可以前往各个业务模块
 *
 *  @param url          schema url
 *  @param parameters   自定义参数，不能走UIApplication的openUrl，在App内直接调此函数
 *
 *  @return             是否能够前往
 */
+ (BOOL)openUrl:(NSURL*)url withParameters:(NSDictionary*)parameters;
@end
