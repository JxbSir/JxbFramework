//
//  AppDelegate.m
//  TestApp
//
//  Created by Peter on 16/7/20.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TestDB.h"
#import <libPatch/libPatch.h>
#import <libRouter/libRouter.h>
#import <libUtility/libUtility.h>
#import <libNetwork/libNetwork.h>
#import <libDBHelper/libDBHelper.h>
#import <libObjection/libObjection.h>
#import "Test1ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //libPatch，JSPatch热修复
//    NSString* path1 = [[NSBundle mainBundle] pathForResource:@"test1" ofType:@".js"];
//    NSString* content1 = [NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:nil];
//    NSString* path2 = [[NSBundle mainBundle] pathForResource:@"test2" ofType:@".js"];
//    NSString* content2 = [NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
//    [[JsPatchManager shareInstance] excuteJsPatch:@[content1,content2]];
    
    //aes + des 加密
//    NSString* key = @"xiaojinjichabihh";
//    NSString* text = @"{\"User\":\"Test11\",\"Pass\":\"111111\",\"Platform\":\"iOS\"}";
//    JxbAesManager* lib = [[JxbAesManager alloc] initWithIV:@"xiaojinjichabihh"];
//    NSString* en = [lib encrypt:key plainText:text];
//    NSLog(en);
//    NSString* de = [lib decrypt:key plainText:en];
//    NSLog(de);
//    
//    NSString* des_en = [JxbDesManager encrypt:@"asd" plainText:@"asd"];
    
    //Realm数据库测试
//    [JxbDbObject registerForRealmObject:@"TestDBClass" fromClass:[TestDB class]];
    
//    NSLog(@"%f",[[NSDate date] timeIntervalSince1970]);
//    NSMutableArray* arr = [NSMutableArray array];
//    for(int i = 0; i<1000000;i++) {
//        TestDB* db = [TestDB registerForRealmObject:@"TestDBClass" fromClass:[TestDB class]];
//        db.pid = [NSString stringWithFormat:@"%d",i];
//        db.aaa = @"caoa";
//        db.bbb = @"caob";
//        [arr addObject:db];
//    }
//    [[JxbDbManager sharedInstance] inserts:arr];
//    [[JxbDbManager sharedInstance] select:@"TestDBClass" where:nil];
//    NSLog(@"%f",[[NSDate date] timeIntervalSince1970]);
    
//    NSArray* arr = [[JxbDbManager sharedInstance] select:@"TestDBClass" where:@"pid='2'"];
//    TestDB* db = arr[0];
//    NSLog(@"%@",db.aaa);
    
    //绑定实例或到到协议，用协议解耦模块化
//    [[JxbObjectionManager shareInstance] bindClass:[Test1ViewController class] toProtocol:@protocol(testProtocol)];
//    [[JxbObjectionManager shareInstance] bindClass:[ViewController class] toProtocol:@protocol(test222Protocol)];
//    Class cls = [[JxbObjectionManager shareInstance] getObject:@protocol(testProtocol)];
//    Class cls2 = [[JxbObjectionManager shareInstance] getObject:@protocol(test222Protocol)];
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = nav;
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];

    //网络库接口
    JxbNetworkConfiguation* config = [JxbNetworkConfiguation defuatConfigurate];
    config.maxRequestConcurrent = 1;
    config.cacheDuration = 10;
    config.baseURL = @"https://192.168.0.131:8443/";
    config.failureBlock = ^(NSError *error) {
        NSLog(@"%@",error);
    };
    
    JxbSecurityPolicy* policy = [JxbSecurityPolicy defaultPolicy];
    policy.policy = JxbSSLPolicy_Oneway;
    policy.allowInvalidCertificates = YES;
    policy.validatesDomainName = NO;
    config.securityPolicy = policy;
    [[JxbNetworkManager sharedInstance] setDefaultConfig:config];
   
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [[JxbNetworkManager sharedInstance] Get:@"sleep.aspx?s=2" success:^(NSDictionary *result) {
//            NSLog(@"%@",result);
//        }];
//    });
//    
//    
    [[JxbNetworkManager sharedInstance] Get:@"demo.json" success:^(NSDictionary *result) {
        NSLog(@"%@",result);
    }];
    
//    while (true) {
//        [[JxbNetworkManager sharedInstance] Get:@"sleep.aspx?s=2" success:^(NSDictionary *result) {
//            NSLog(@"%@",result);
//        }];
//        
//        [[NSRunLoop currentRunLoop] run];
//    }

    
    
    
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
    return [JxbRouterManager openUrl:url];
}
@end
