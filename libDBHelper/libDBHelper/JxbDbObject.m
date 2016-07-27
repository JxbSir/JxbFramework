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

+ (id)registerForRealmObject:(NSString *)className withProtocol:(Protocol *)protocol {
    //注册一个继承RLMObject的类
    Class c = objc_allocateClassPair([RLMObject class], [className UTF8String], 0);

    //获取协议中的所有属性
    unsigned int count = 0;
    objc_property_t *list = protocol_copyPropertyList(protocol, &count);
    for (uint i = 0; i < count; i++) {
        objc_property_t property = list[i];
        const char *propertyName = property_getName(property);
        NSString* proName = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSString* _proName = [NSString stringWithFormat:@"_%@",proName];
        objc_property_attribute_t type = { "T", "@\"NSString\"" };
        objc_property_attribute_t ownership1 = { "N", "" }; //N = nonatomic
        objc_property_attribute_t ownership2 = { "C", "" };
        objc_property_attribute_t backingivar  = { "V", [_proName UTF8String] };
        objc_property_attribute_t attrs[] = { type, ownership1, ownership2, backingivar };
        if (class_addProperty(c, propertyName, attrs, 4)) {
            NSLog(@"class_addProperty success");
        }
        else {
            NSLog(@"class_addProperty failure");
        }
      
        class_addIvar(c, [_proName UTF8String],sizeof(NSString *), 0, "@");
        
        NSString* methodName_setter = [NSString stringWithFormat:@"set%@%@:",[[proName substringToIndex:1] uppercaseString], [proName substringFromIndex:1]];
        SEL sel_setter = NSSelectorFromString(methodName_setter);
        IMP imp_setter = imp_implementationWithBlock(^(id _self, id string) {
            Ivar ivar = class_getInstanceVariable([_self class], [_proName UTF8String]);
            id oldValue = object_getIvar(_self, ivar);
            if (oldValue != string)
                object_setIvar(_self, ivar, [string copy]);
        });
        class_addMethod(c, sel_setter, imp_setter, nil);
        
        NSString* methodName_getter = proName;
        SEL sel_getter = NSSelectorFromString(methodName_getter);
        IMP imp_getter = imp_implementationWithBlock(^(id _self, id string) {
            Ivar ivar = class_getInstanceVariable([_self class], [_proName UTF8String]);
            id oldValue = object_getIvar(_self, ivar);
            return oldValue;
        });
        class_addMethod(c, sel_getter, imp_getter, nil);
        
        NSString* methodName_kvc = @"valueForKey:";
        SEL sel_kvc = NSSelectorFromString(methodName_kvc);
        IMP imp_kvc = imp_implementationWithBlock(^(id _self, id string) {
            Ivar ivar = class_getInstanceVariable([_self class], [[NSString stringWithFormat:@"_%@",string] UTF8String]);
            id oldValue = object_getIvar(_self, ivar);
            return oldValue;
        });
        class_addMethod(c, sel_kvc, imp_kvc, nil);
    }
    free(list);
    objc_registerClassPair(c);
    id obj = [c new];
    return obj;
}

@end
