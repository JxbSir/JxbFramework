//
//  NSDictionary+Swizzling.m
//  Tripinsiders
//
//  Created by Peter on 16/6/13.
//  Copyright © 2016年 Tripinsiders. All rights reserved.
//

#import "NSDictionary+Swizzling.h"
#import <objc/runtime.h>

@implementation NSDictionary (Swizzling)

+ (void)load {
    Method oriMethod = class_getClassMethod(objc_getClass("__NSDictionaryI"), @selector(dictionaryWithObjects:forKeys:count:));
    Method newMethod = class_getClassMethod(objc_getClass("__NSDictionaryI"), @selector(dictionaryWithObjects_swizzling:forKeys:count:));
    
    method_exchangeImplementations(oriMethod, newMethod);
}

+ (instancetype)dictionaryWithObjects_swizzling:(id  _Nonnull __unsafe_unretained * const)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {
    if (cnt > 0) {
        id _Nonnull __unsafe_unretained *obs = objects;
        for (int i = 0; i < cnt; i++) {
            if (obs[i] == nil) {
#if DEBUG
                NSAssert(false, @"请注意，字典中value不能为nil");
#endif
                obs[i] = [NSNull null];
            }
        }
    }
    return [self dictionaryWithObjects_swizzling:objects forKeys:keys count:cnt];
}
@end
