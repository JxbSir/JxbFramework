//
//  NSString+URLEncode.m
//
//  Created by Kevin Renskers on 31-10-13.
//  Copyright (c) 2013 Kevin Renskers. All rights reserved.
//

#import "NSString+URLEncode.h"

@implementation NSString (URLEncode)

- (NSString *)URLEncode {
    return [self URLEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)URLEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}

- (NSString *)URLDecode {
    return [self URLDecodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)URLDecodeUsingEncoding:(NSStringEncoding)encoding {
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [outputStr length])];
    return [outputStr stringByRemovingPercentEncoding];
}

@end
