//
//  JxbTools.m
//  libUtility
//
//  Created by Peter on 16/7/26.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbTools.h"
#import <CommonCrypto/CommonHMAC.h>
#import "sys/utsname.h"

@implementation JxbTools

+ (NSString*)hmacForKeyAndData:(NSString *)key data:(NSString *)data {
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData* hmacData = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    return [self hexadecimalString:hmacData];
}

+ (NSString*)hexadecimalString:(NSData *)data {
    /* Returns hexadecimal string of NSData. Empty string if data is empty.   */
    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
    if (!dataBuffer)
        return [NSString string];
    NSUInteger          dataLength  = [data length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    return [NSString stringWithString:hexString];
}

+ (NSString *)getDeviceType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    NSArray *modelArray = @[
                            
                            @"i386", @"x86_64",
                            
                            @"iPhone1,1",
                            @"iPhone1,2",
                            @"iPhone2,1",
                            @"iPhone3,1",
                            @"iPhone3,2",
                            @"iPhone3,3",
                            @"iPhone4,1",
                            @"iPhone5,1",
                            @"iPhone5,2",
                            @"iPhone5,3",
                            @"iPhone5,4",
                            @"iPhone6,1",
                            @"iPhone6,2",
                            @"iPhone7,2",
                            @"iPhone7,1",
                            @"iPhone8,1",
                            @"iPhone8,2",
                            
                            @"iPod1,1",
                            @"iPod2,1",
                            @"iPod3,1",
                            @"iPod4,1",
                            @"iPod5,1",
                            
                            @"iPad1,1",
                            @"iPad2,1",
                            @"iPad2,2",
                            @"iPad2,3",
                            @"iPad2,4",
                            @"iPad3,1",
                            @"iPad3,2",
                            @"iPad3,3",
                            @"iPad3,4",
                            @"iPad3,5",
                            @"iPad3,6",
                            
                            @"iPad2,5",
                            @"iPad2,6",
                            @"iPad2,7",
                            
                            @"iPad4,1",
                            @"iPad4,2",
                            @"iPad4,3",
                            
                            @"iPad5,3",
                            @"iPad5,4",
                            
                            @"iPad6,7",
                            @"iPad6,8",
                            
                            @"iPad4,4",
                            @"iPad4,5",
                            @"iPad4,6",
                            
                            @"iPad4,7",
                            @"iPad4,8",
                            @"iPad4,9",
                            
                            @"iPad5,1",
                            @"iPad5,2",
                            ];
    NSArray *modelNameArray = @[
                                
                                @"iPhone Simulator",
                                @"iPhone Simulator",
                                @"iPhone 2G",
                                @"iPhone 3G",
                                @"iPhone 3GS",
                                @"iPhone 4(GSM)",
                                @"iPhone 4(GSM Rev A)",
                                @"iPhone 4(CDMA)",
                                @"iPhone 4S",
                                @"iPhone 5(GSM)",
                                @"iPhone 5(GSM+CDMA)",
                                @"iPhone 5c(GSM)",
                                @"iPhone 5c(Global)",
                                @"iphone 5s(GSM)",
                                @"iphone 5s(Global)",
                                @"iPhone 6",
                                @"iPhone 6 Plus",
                                @"iPhone 6s",
                                @"iPhone 6s Plus",
                                
                                @"iPod Touch 1G",
                                @"iPod Touch 2G",
                                @"iPod Touch 3G",
                                @"iPod Touch 4G",
                                @"iPod Touch 5G",
                                
                                @"iPad",
                                @"iPad 2(WiFi)",
                                @"iPad 2(GSM)",
                                @"iPad 2(CDMA)",
                                @"iPad 2(WiFi + New Chip)",
                                @"iPad 3(WiFi)",
                                @"iPad 3(GSM+CDMA)",
                                @"iPad 3(GSM)",
                                @"iPad 4(WiFi)",
                                @"iPad 4(GSM)",
                                @"iPad 4(GSM+CDMA)",
                                
                                @"iPad air (WiFi)",
                                @"iPad air (GSM)",
                                @"ipad air (GSM+CDMA)",
                                
                                @"iPad air2 (WiFi)",
                                @"iPad air2 (GSM+CDMA)",
                                
                                @"iPad Pro (WiFi)",
                                @"iPad Pro (GSM+CDMA)",
                                
                                @"iPad mini (WiFi)",
                                @"iPad mini (GSM)",
                                @"ipad mini (GSM+CDMA)",
                                
                                @"iPad mini2 (WiFi)",
                                @"iPad mini2 (GSM)",
                                @"ipad mini2 (GSM+CDMA)",
                                
                                @"iPad mini3 (WiFi)",
                                @"iPad mini3 (GSM)",
                                @"ipad mini3 (GSM+CDMA)",
                                
                                @"iPad mini4 (WiFi)",
                                @"iPad mini4 (GSM+CDMA)",
                                
                                ];
    NSInteger modelIndex = - 1;
    NSString *modelNameString = nil;
    modelIndex = [modelArray indexOfObject:deviceString];
    if (modelIndex >= 0 && modelIndex < [modelNameArray count]) {
        modelNameString = [modelNameArray objectAtIndex:modelIndex];
    }
    return modelNameString ?: deviceString;
}

+ (void)changeColorWithAnimation:(CGFloat)duration fromColorHex:(NSString*)fromColorHex toHex:(NSString*)toHex doBlock:(void(^)(UIColor* color))doBlock {
    unsigned long fromcolor = strtoul([fromColorHex UTF8String],0,16);
    CGFloat from_r = (float)((fromcolor & 0xFF0000) >> 16);
    CGFloat from_g = (float)((fromcolor & 0xFF00) >> 8);
    CGFloat from_b = (float)(fromcolor & 0xFF);
    
    unsigned long tocolor = strtoul([toHex UTF8String],0,16);
    CGFloat to_r = (float)((tocolor & 0xFF0000) >> 16);
    CGFloat to_g = (float)((tocolor & 0xFF00) >> 8);
    CGFloat to_b = (float)(tocolor & 0xFF);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        int p = duration / 0.01;
        for (int i = 0; i <= p; i++) {
            CGFloat r = (to_r - from_r) * (1.0 * i / p) + from_r;
            CGFloat g = (to_g - from_g) * (1.0 * i / p) + from_g;
            CGFloat b = (to_b - from_b) * (1.0 * i / p) + from_b;
            
            UIColor* color = [UIColor colorWithRed:r/255.0 green:g/255. blue:b/255. alpha:1];;
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (doBlock != NULL)
                    doBlock(color);
            });
            
            [NSThread sleepForTimeInterval:0.01];
        }
    });
}

+ (UIColor*)convertColor:(UIColor*)fromColor toColor:(UIColor*)toColor progress:(CGFloat)progress {
    const CGFloat *components_from = CGColorGetComponents(fromColor.CGColor);
    CGFloat from_r = components_from[0];
    CGFloat from_g = components_from[1];
    CGFloat from_b = components_from[2];
    
    const CGFloat *components_to = CGColorGetComponents(toColor.CGColor);
    CGFloat to_r = components_to[0];
    CGFloat to_g = components_to[1];
    CGFloat to_b = components_to[2];
    
    UIColor* color = [UIColor colorWithRed:(from_r + progress * (to_r - from_r)) green:(from_g + progress * (to_g - from_g)) blue:(from_b + progress * (to_b - from_b)) alpha:1];
    return color;
}
@end
