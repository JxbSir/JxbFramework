//
//  UIImage+ReverseImage.h
//  Tripinsiders
//
//  Created by ZhouQian on 16/4/6.
//  Copyright © 2016年 Tripinsiders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ReverseImage)
+ (UIImage *)imageUpSideDown:(UIImage *)image;
+ (UIImage *)imageLeft:(UIImage *)image;
+ (UIImage *)imageRight:(UIImage *)image;
@end
