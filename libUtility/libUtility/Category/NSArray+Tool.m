//
//  NSArray+Tool.m
//  TP
//
//  Created by Peter on 15/9/23.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "NSArray+Tool.h"

@implementation NSArray (Tool)

- (NSString*)toString:(NSString*)spilt {
    NSMutableString* text = [NSMutableString string];
    for (NSString* item in self) {
        [text appendString:item];
        if (spilt.length > 0) {
            [text appendString:spilt];
        }
    }
    NSString* result = [text substringWithRange:NSMakeRange(0, text.length - spilt.length)];
    return result;
}
@end
