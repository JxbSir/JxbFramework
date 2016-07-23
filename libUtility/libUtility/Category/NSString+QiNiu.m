//
//  NSString+QiNiu.m
//  Tripinsiders
//
//  Created by Peter on 16/5/9.
//  Copyright © 2016年 Tripinsiders. All rights reserved.
//

#import "NSString+QiNiu.h"

@implementation NSString (QiNiu)

- (NSString*)imageMogr:(NSString*)param value:(NSString*)value {
    NSString* url = self;
    if ([self containsString:@"imageMogr2"]) {
        if ([self containsString:param]) {
            NSRange r1 = [self rangeOfString:[NSString stringWithFormat:@"/%@/",param]];
            NSString* temp = [self substringFromIndex:r1.location+ r1.length];
            if ([temp containsString:@"/"]) {
                NSString* prefix = [self substringToIndex:r1.location];
                NSRange r2 = [temp rangeOfString:@"/"];
                NSString* suffix = [temp substringFromIndex:r2.location + r2.length];
                url = [NSString stringWithFormat:@"%@/%@/%@/%@",prefix,param,value,suffix];
            }
            else {
                NSString* prefix = [self substringToIndex:r1.location];
                url = [NSString stringWithFormat:@"%@/%@/%@",prefix,param,value];
            }
        }
        else {
            url = [NSString stringWithFormat:@"%@/%@/%@",self,param,value];
        }
    }
    else {
        url = [NSString stringWithFormat:@"%@?imageMogr2/%@/%@",self,param,value];
    }
    return url;
}

- (NSString*)noMogr {
    NSRange r = [self rangeOfString:@"?"];
    if (r.location != NSNotFound) {
        return  [self substringToIndex:r.location];
    }
    return self;
}

- (NSString*)thumbnail:(NSInteger)size {
    NSString* value = [NSString stringWithFormat:@"%zdx",size];
    NSString* url = [self imageMogr:@"thumbnail" value:value];
    return url;
}

- (NSString*)webp {
    NSString* url = [self imageMogr:@"format" value:@"webp"];
    return url;
}

@end
