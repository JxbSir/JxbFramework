//
//  NSString+Equal.m
//  TP
//
//  Created by Peter on 15/12/6.
//  Copyright © 2015年 VizLab. All rights reserved.
//

#import "NSString+Equal.h"
#import <Foundation/Foundation.h>

@implementation NSString (Equal)

- (BOOL)isEqualWith:(NSString *)string {
    return [self isEqualToString:string];
}
@end
