//
//  JxbPushManager.m
//  libRouter
//
//  Created by Peter on 16/7/22.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbPushManager.h"

@implementation JxbPushManager

+ (void)pushController:(UIViewController *)controller {
    [self pushController:controller animated:YES];
}

+ (void)pushController:(UIViewController *)controller animated:(BOOL)animated {
    UINavigationController* nav = [self p_getNaviController];
    if (nav) {
        [nav pushViewController:controller animated:animated];
    }
}

+ (UIViewController*)p_getRootController {
    UIViewController* root = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while (root.presentedViewController) {
        root = root.presentedViewController;
    }
    return root;
}
+ (UINavigationController*)p_getNaviController {
    UIViewController* root = [self p_getRootController];
    if ([root isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tab = (UITabBarController*)root;
        return tab.selectedViewController;
    }
    return root;
}


@end
