//
//  NSString+ConvertToColor.m
//  TP
//
//  Created by ZhouQian on 16/1/26.
//  Copyright © 2016年 VizLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+ConvertToColor.h"

#define HEXCOLORA(rgbValue, a)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:a]
#define HEXCOLOR(rgbValue)      HEXCOLORA(rgbValue, 1.0)

@implementation NSString (ConvertToColor)

+ (UIColor *)colorFromString:(NSString *)str {
    unsigned colorInt = 0;
    [[NSScanner scannerWithString:str] scanHexInt:&colorInt];
    return HEXCOLOR(colorInt);
}
@end
