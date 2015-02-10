//
//  UIImage+RenderedImage.h
//  ZJOL
//
//  Created by Peter on 15/1/6.
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RenderedImage)

+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size;
@end
