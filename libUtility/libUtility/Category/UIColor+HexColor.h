//
//  UIColor+HexColor.h
//  libUtility
//
//  Created by Peter on 16/7/25.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 普通定义 */
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define RGB_A(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define HexColor(colorV) [UIColor colorWithHexColorString:@#colorV]
#define HexColorAlpha(colorV,a) [UIColor colorWithHexColorString:@#colorV alpha:a];
/** 随机色 */
#define RamdomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0f green:arc4random_uniform(256)/255.0f blue:arc4random_uniform(256)/255.0f alpha:1.0f]

@interface UIColor (HexColor)

/**
 *  十六进制颜色
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString;

/**
 *  十六进制颜色:含alpha
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString alpha:(float)alpha;
@end
