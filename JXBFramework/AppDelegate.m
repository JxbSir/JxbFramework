//
//  AppDelegate.m
//  JXBFramework
//
//  Created by Peter on 15/2/10.
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginParser.h"
#import "testVC.h"
#import "UIImage+RenderedImage.h"



@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    NSString* url = @"http://11.23.11.98:9090/tzs/version/get";
//    NSDictionary* dicParas = @{@"custVersion":@"1.0.1", @"phoneType":@"ios"};
    
    
    [[XBApi SharedXBApi] requestSyncWithURL:@"http://json.1yyg.com/android/index?action=getADListForPage&sortID=13" paras:nil type:XBHttpResponseType_Json];
    
//    [[XBApi SharedXBApi] requestWithURL:url paras:dicParas type:XBHttpResponseType_Json success:^(AFHTTPRequestOperation* operation,NSObject* result){
//        LoginParser* lm = [[LoginParser alloc] initWithDictionary:(NSDictionary*)result];
//        NSLog(@"%@",lm);
//    } failure:^(NSError* error){
//        NSLog(@"%@",error);
//    }];
    
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    
    UIViewController *rootViewController = [self setupRootViewController];
    [[self window] setRootViewController:rootViewController];
    
    // set  backgroundColor
    [[self window] setBackgroundColor:[UIColor whiteColor]];
    // set  makeKeyAndVisible
    [[self window] makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UITabBarController *)setupRootViewController{
    
    testVC *homeVC = [[testVC alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UIImage *unselectedImage = [UIImage imageNamed:@"tab_search"];
    UIImage *selectedImage = [UIImage imageNamed:@"tab_search_s"];
    
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"aaa"
                                                      image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    homeVC.tabBarItem.tag = 0;
    
    testVC * mineVc = [[testVC alloc] init];
    UINavigationController * mineNav = [[UINavigationController alloc] initWithRootViewController:mineVc];
    unselectedImage = [UIImage imageNamed:@"tab_more1"];
    selectedImage = [UIImage imageNamed:@"tab_more1_s"];
    
    mineNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"bbb"
                                                       image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                               selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    mineNav.tabBarItem.tag = 1;

    
    testVC * moreVc = [[testVC alloc] init];
    UINavigationController * moreNav = [[UINavigationController alloc] initWithRootViewController:moreVc];
    unselectedImage = [UIImage imageNamed:@"tab_more"];
    selectedImage = [UIImage imageNamed:@"tab_more_s"];
    
    moreNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"ccc"
                                                       image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                               selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    moreNav.tabBarItem.tag = 2;
    
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[homeNav,mineNav, moreNav];
    tabBarController.delegate = self;
    
    
    // customise TabBar UI Effect
    [UITabBar appearance].tintColor = [UIColor redColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    
    // customise NavigationBar UI Effect
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithRenderColor:[UIColor blueColor] renderSize:CGSizeMake(10., 10.)] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16.],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
    UITabBar *tabBar = tabBarController.tabBar;
    tabBar.backgroundColor = [UIColor greenColor];
    
    return tabBarController;
}


@end
