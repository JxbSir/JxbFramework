//
//  JxbSafeAsync.h
//  TripBaseUI
//
//  Created by Peter on 16/8/25.
//  Copyright © 2016年 Peter. All rights reserved.
//
//  多线程读写安全类

#import <Foundation/Foundation.h>

@interface JxbSafeAsync : NSObject

/**
 *  执行一个写的操作
 *
 *  @param block
 */
- (void)addWriteBlock:(void(^)(void))block;

/**
 *  执行一个读的操作
 *
 *  @param block
 */
- (void)addGetBlock:(void(^)(void))block;

@end
