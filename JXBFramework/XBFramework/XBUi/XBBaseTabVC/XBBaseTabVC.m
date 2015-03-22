//
//  XBBaseTabVC.m
//  JXBFramework
//
//  Created by Peter on 15/3/22.
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import "XBBaseTabVC.h"

@implementation XBBaseTabItem
@end

@implementation XBBaseTabVC

- (XBBaseTabVC*)initWithItems:(NSArray *)items
{
    self = [super init];
    if(self)
    {
        NSMutableArray* navVCs = [NSMutableArray array];
        for(XBBaseTabItem* item in items)
        {
            item.rootVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:item.title image:[[UIImage imageNamed:item.unselectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:item.selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:item.rootVC];
            [navVCs addObject:nav];
        }
        self.viewControllers = navVCs;
        self.tabBar.backgroundColor = [UIColor clearColor];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:mainColor} forState:UIControlStateSelected];
        
        // customise NavigationBar UI Effect
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithRenderColor:mainColor renderSize:CGSizeMake(10., 10.)] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16.],NSForegroundColorAttributeName:[UIColor blackColor]}];
        
    }
    return self;
}
@end