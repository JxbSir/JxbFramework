//
//  JxbTools.h
//  libUtility
//
//  Created by Peter on 16/7/26.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JxbTools : NSObject

/**
 *  通过Key获取hmac
 *
 *  @param key  key
 *  @param data data
 *
 *  @return hmac
 */
+ (NSString * _Nonnull)hmacForKeyAndData:(NSString * _Nonnull)key data:(NSString * _Nonnull)data;

/**
 *  获取手机型号
 *
 *  @return
 */
+ (NSString * _Nonnull)getDeviceType;

/**
 *  动画修改颜色
 *
 *  @param duration            时间
 *  @param fromColorHex        000000
 *  @param toHex               ffffff
 *  @param doBlock             操作
 */
+ (void)changeColorWithAnimation:(CGFloat)duration fromColorHex:(NSString * _Nonnull)fromColorHex toHex:(NSString * _Nonnull)toHex doBlock:(void(^ _Nullable)(UIColor * _Nonnull color))doBlock;

/**
 *  颜色渐变(只支持RGB颜色，[UIColor grayColor]这种目标暂不支持)
 *
 *  @param fromColor 初始颜色
 *  @param toColor   目标颜色
 *  @param progress  进度
 *
 *  @return 颜色
 */
+ (UIColor * _Nonnull)convertColor:(UIColor * _Nonnull)fromColor toColor:(UIColor * _Nonnull)toColor progress:(double)progress;
@end
