//
//  JxbDbObject.m
//  libDBHelper
//
//  Created by Peter on 16/7/27.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbDbObject.h"
#import <objc/runtime.h>
#import <Realm/Realm.h>

@implementation JxbDbObject

+ (id)registerForRealmObject:(NSString *)className fromClass:(Class)fromClass {
    //若已经注册，就直接返回实例
    Class class = NSClassFromString(className);
    if (class) {
        return [class new];
    }
    //创建一个继承RLMObject的类
    class = objc_allocateClassPair([RLMObject class], [className UTF8String], 0);
    //获取对象中的所有属性
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList(fromClass, &count);
    for (uint i = 0; i < count; i++) {
        objc_property_t property = list[i];
        const char *propertyName = property_getName(property);
        NSString* proName = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSString* _proName = [NSString stringWithFormat:@"_%@",proName];
        //插入属性
        objc_property_attribute_t type = { "T", "@\"NSString\"" };
        objc_property_attribute_t ownership1 = { "N", "" }; //N = nonatomic
        objc_property_attribute_t ownership2 = { "C", "" };
        objc_property_attribute_t backingivar  = { "V", [_proName UTF8String] };
        objc_property_attribute_t attrs[] = { type, ownership1, ownership2, backingivar };
        if (class_addProperty(class, propertyName, attrs, 4)) {
            NSLog(@"class_addProperty success");
        }
        else {
            NSLog(@"class_addProperty failure");
        }
        //插入成员变量
        class_addIvar(class, [_proName UTF8String],sizeof(NSString *), 0, "@");
        //插入setter函数
        NSString* methodName_setter = [NSString stringWithFormat:@"set%@%@:",[[proName substringToIndex:1] uppercaseString], [proName substringFromIndex:1]];
        SEL sel_setter = NSSelectorFromString(methodName_setter);
        IMP imp_setter = imp_implementationWithBlock(^(id _self, id string) {
            Ivar ivar = class_getInstanceVariable([_self class], [_proName UTF8String]);
            id oldValue = object_getIvar(_self, ivar);
            if (oldValue != string)
                object_setIvar(_self, ivar, [string copy]);
        });
        class_addMethod(class, sel_setter, imp_setter, nil);
        //插入getter函数
        NSString* methodName_getter = proName;
        SEL sel_getter = NSSelectorFromString(methodName_getter);
        IMP imp_getter = imp_implementationWithBlock(^(id _self, id string) {
            Ivar ivar = class_getInstanceVariable([_self class], [_proName UTF8String]);
            id oldValue = object_getIvar(_self, ivar);
            return oldValue;
        });
        class_addMethod(class, sel_getter, imp_getter, nil);
    }
    free(list);
    //插入kvc函数
    NSString* methodName_kvc = @"valueForKey:";
    SEL sel_kvc = NSSelectorFromString(methodName_kvc);
    IMP imp_kvc = imp_implementationWithBlock(^(id _self, id string) {
        Ivar ivar = class_getInstanceVariable([_self class], [[NSString stringWithFormat:@"_%@",string] UTF8String]);
        id oldValue = object_getIvar(_self, ivar);
        return oldValue;
    });
    class_addMethod(class, sel_kvc, imp_kvc, nil);
    //处理primaryKey
    SEL sel_pk = NSSelectorFromString(@"primaryKey");
    Method method_pk_super = class_getClassMethod(class, sel_pk);
    Method method_pk = class_getClassMethod(fromClass, sel_pk);
    if (method_pk != NULL) {
        IMP imp_pk = method_getImplementation(method_pk);
        if (imp_pk != NULL) {
            if (method_pk_super == NULL) {
               BOOL bAdd = class_addMethod(class, sel_pk, imp_pk, method_getTypeEncoding(method_pk));
                NSLog(@"类方法添加%@",bAdd?@"成功":@"失败");
            }
            else {
                BOOL bAdd = class_addMethod(object_getClass(class), sel_pk, imp_pk, method_getTypeEncoding(method_pk));
                NSLog(@"类方法添加%@",bAdd?@"成功":@"失败");
            }
        }
    }
    //注册
    objc_registerClassPair(class);
    id obj = [class new];
    return obj;
}

@end
