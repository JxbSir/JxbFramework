//
//  JxbDbObject.h
//  libDBHelper
//
//  Created by Peter on 16/7/27.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JxbDbObject : NSObject

/**
 *  注册一个继承自RealmObject的对象，为了不暴露Realm库
 *  切记，初始化对象的属性都必须为NSString类型，一个属性相对于一个数据库字段名
 *
 *  @param className 动态注册类名，相当于数据库表名
 *
 *  @return 类
 */
+ (id)registerForRealmObject:(NSString*)className;
@end
