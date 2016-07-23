//
//  UIImage+ReverseImage.m
//  Tripinsiders
//
//  Created by ZhouQian on 16/4/6.
//  Copyright © 2016年 Tripinsiders. All rights reserved.
//

#import "UIImage+ReverseImage.h"

@implementation UIImage (ReverseImage)

+ (UIImage *)imageUpSideDown:(UIImage *)image {
    return [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:(UIImageOrientationDown)];
}

+ (UIImage *)imageLeft:(UIImage *)image {
    return [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:(UIImageOrientationLeft)];
}

+ (UIImage *)imageRight:(UIImage *)image {
    return [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:(UIImageOrientationRight)];
}
@end
