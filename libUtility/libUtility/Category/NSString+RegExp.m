//
//  NSString+RegExp.m
//  Tripinsiders
//
//  Created by ZhouQian on 16/5/5.
//  Copyright © 2016年 Tripinsiders. All rights reserved.
//

#import "NSString+RegExp.h"

@implementation NSString (RegExp)

- (BOOL)validateWithRegExp:(NSString *)regExp {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp];
    return [predicate evaluateWithObject:self];
}
@end
