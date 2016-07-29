//
//  JxbDbManager.h
//  libDBHelper
//
//  Created by Peter on 16/7/27.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JxbDbManager : NSObject

/**
 *  单例模式
 *
 *  @return 实例
 */
+ (instancetype)sharedInstance;

/**
 *  插入数据（切记，obj的模型属性全为NSString）
 *
 *  @param obj
 */
- (void)insert:(id)obj;
- (void)inserts:(NSArray *)objs;

/**
 *  更新数据（切记，obj的模型属性全为NSString）
 *
 *  @param obj
 */
- (void)update:(id)obj;
- (void)updates:(NSArray *)objs;
/**
 *  删除数据
 *
 *  @param tableName    表名
 *  @param primaryValue 主键字段值
 */
- (void)remove:(NSString *)tableName primaryValue:(NSString *)primaryValue;

/**
 *  查询数据
 *
 *  @param tableName 表名
 *  @param where     where查询条件，例如：pid='1' or pid='2'
 */
- (void)select:(NSString *)tableName where:(NSString *)where;

/**
 *  查询数据
 *
 *  @param tableName 表名
 *  @param predicate 谓词
 */
- (void)select:(NSString *)tableName predicate:(NSPredicate *)predicate;
@end
