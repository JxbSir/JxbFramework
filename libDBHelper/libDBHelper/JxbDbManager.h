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
+ (instancetype _Nonnull)sharedInstance;

/**
 *  插入数据（切记，obj的模型属性全为NSString）
 *
 *  @param obj
 */
- (void)insert:(id _Nonnull)obj;
- (void)inserts:(NSArray * _Nonnull)objs;

/**
 *  更新数据（切记，obj的模型属性全为NSString）
 *
 *  @param obj
 */
- (void)update:(id _Nonnull)obj;
- (void)updates:(NSArray * _Nonnull)objs;
/**
 *  删除数据
 *
 *  @param tableName    表名
 *  @param primaryValue 主键字段值
 */
- (void)remove:(NSString * _Nonnull)tableName primaryValue:(NSString * _Nonnull)primaryValue;

/**
 *  查询数据
 *
 *  @param tableName 表名
 *  @param where     where查询条件，例如：pid='1' or pid='2'
 */
- (NSArray * _Nullable)select:(NSString * _Nonnull)tableName where:(NSString * _Nullable)where;

/**
 *  查询数据
 *
 *  @param tableName    表名
 *  @param where        where查询条件，例如：pid='1' or pid='2'
 *  @param sortProperty 排序字段名
 *  @param ascending    升序
 */
- (NSArray * _Nullable)select:(NSString * _Nonnull)tableName where:(NSString * _Nullable)where sortProperty:(NSString * _Nonnull)sortProperty ascending:(BOOL)ascending;

/**
 *  查询数据
 *
 *  @param tableName 表名
 *  @param predicate 谓词
 */
- (NSArray * _Nullable)select:(NSString * _Nonnull)tableName predicate:(NSPredicate * _Nullable)predicate;

/**
 *  查询数据
 *
 *  @param tableName    表名
 *  @param predicate    谓词
 *  @param sortProperty 排序字段名称
 *  @param ascending    升序
 */
- (NSArray * _Nullable)select:(NSString * _Nonnull)tableName predicate:(NSPredicate * _Nullable)predicate sortProperty:(NSString * _Nonnull)sortProperty ascending:(BOOL)ascending;
@end
