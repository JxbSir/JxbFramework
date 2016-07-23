//
//  NSArray+Swizzling.m
//  TP
//
//  Created by Peter on 16/1/22.
//  Copyright © 2016年 VizLab. All rights reserved.
//

#import "NSArray+Swizzling.h"
#import <objc/runtime.h>

@implementation NSArray (Swizzling)

+ (void)load {
    Method oriMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method newMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex_Swizzling:));
    
    method_exchangeImplementations(oriMethod, newMethod);
}

- (id)objectAtIndex_Swizzling:(NSUInteger)index {
    if (self.count <= index) {
#if DEBUG
        NSAssert(false, @"bounds out......");
#endif
        return nil;
    }
    return [self objectAtIndex_Swizzling:index];
}

@end
