//
//  JxbPushManager.h
//  libRouter
//
//  Created by Peter on 16/7/22.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JxbPushManager : NSObject

/**
 *  Push Controller
 *
 *  @param controller VC
 */
+ (void)pushController:(UIViewController*)controller;
/**
 *  Push Controller
 *
 *  @param controller VC
 *  @param animated   animated
 */
+ (void)pushController:(UIViewController*)controller animated:(BOOL)animated;
@end
