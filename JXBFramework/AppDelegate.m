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
#import "firstVC.h"
#import "secondVC.h"
#import "ThirdVC.h"
#import "XBBaseTabVC.h"



@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    NSString* url = @"http://11.23.11.98:9090/tzs/version/get";
//    NSDictionary* dicParas = @{@"custVersion":@"1.0.1", @"phoneType":@"ios"};
    
    
//    [[XBApi SharedXBApi] requestSyncWithURL:@"http://json.1yyg.com/android/index?action=getADListForPage&sortID=13" paras:nil type:XBHttpResponseType_Json];
    
//    [[XBApi SharedXBApi] requestWithURL:url paras:dicParas type:XBHttpResponseType_Json success:^(AFHTTPRequestOperation* operation,NSObject* result){
//        LoginParser* lm = [[LoginParser alloc] initWithDictionary:(NSDictionary*)result];
//        NSLog(@"%@",lm);
//    } failure:^(NSError* error){
//        NSLog(@"%@",error);
//    }];
    
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    
    //UIViewController *rootViewController = [self setupRootViewController];
    
    firstVC* v1 = [[firstVC alloc] init];
    XBBaseTabItem* item1 = [[XBBaseTabItem alloc]init];
    item1.title = @"首页";
    item1.selectedImage = @"tab-home-s";
    item1.unselectedImage = @"tab-home";
    item1.rootVC = v1;
    
    secondVC* v2 = [[secondVC alloc] init];
    XBBaseTabItem* item2 = [[XBBaseTabItem alloc]init];
    item2.title = @"购物车";
    item2.selectedImage = @"tab-cart-s";
    item2.unselectedImage = @"tab-cart";
    item2.rootVC = v2;
    
    ThirdVC* v3 = [[ThirdVC alloc] init];
    XBBaseTabItem* item3 = [[XBBaseTabItem alloc]init];
    item3.title = @"我的";
    item3.selectedImage = @"tab-mine-s";
    item3.unselectedImage = @"tab-mine";
    item3.rootVC = v3;
    
    XBBaseTabVC* tab = [[XBBaseTabVC alloc] initWithItems:@[item1,item2,item3]];
    
    
    [[self window] setRootViewController:tab];
    
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

@end
