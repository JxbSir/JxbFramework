//
//  NSMutableDictionary+Swizzling.m
//  TP
//
//  Created by Peter on 16/1/22.
//  Copyright © 2016年 VizLab. All rights reserved.
//

#import "NSMutableDictionary+Swizzling.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (Swizzling)

+ (void)load {
    Method oriMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:));
    Method newMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject_swizzling:forKey:));
    
    method_exchangeImplementations(oriMethod, newMethod);
}

- (void)setObject_swizzling:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!anObject) {
#if DEBUG
        NSAssert(false, @"object value is nil......");
#endif
        return ;
    }
    [self setObject_swizzling:anObject forKey:aKey];
}

@end
