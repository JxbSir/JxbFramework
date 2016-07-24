//
//  AppDelegate.m
//  TestApp
//
//  Created by Peter on 16/7/20.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <libPatch/libPatch.h>
#import <libRouter/libRouter.h>
#import <libEncryption/libEncryption.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    NSString* path1 = [[NSBundle mainBundle] pathForResource:@"test1" ofType:@".js"];
//    NSString* content1 = [NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:nil];
//    NSString* path2 = [[NSBundle mainBundle] pathForResource:@"test2" ofType:@".js"];
//    NSString* content2 = [NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
//    [[JsPatchManager shareInstance] excuteJsPatch:@[content1,content2]];
    
    
    NSString* key = @"xiaojinjichabihh";
    NSString* text = @"ni shi bichi";
    JxbEncryptManager* lib = [[JxbEncryptManager alloc] initWithIV:@"xiaojinjichabihh"];
    NSString* en = [lib encrypt:key plainText:text];
    NSLog(en);
    NSString* de = [lib decrypt:key plainText:en];
    NSLog(de);
    
    
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];

    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = nav;
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];
    
    
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

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [libRouterManager openUrl:url];
}
@end
