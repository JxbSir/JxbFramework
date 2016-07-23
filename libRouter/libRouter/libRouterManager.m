//
//  libRouterManager.m
//  libRouter
//
//  Created by Peter on 16/7/22.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "libRouterManager.h"
#import "JxbPushManager.h"
#import "MGJRouter.h"

#define schemaController    @"SchemaController"

@implementation libRouterManager

+ (NSString *)p_patternUrl:(NSString*)appSchema url:(NSString*)url {
    NSString *_url = [NSString stringWithFormat:@"%@://%@",appSchema,url];
    return _url;
}

+ (void)registerCommonPush:(NSString*)appSchema {
    [MGJRouter registerURLPattern:[self p_patternUrl:appSchema url:[@"NaviPush/:" stringByAppendingString:schemaController]] toHandler:^(NSDictionary *routerParameters) {
        NSString* controllerClassName = routerParameters[schemaController];
        if (controllerClassName) {
            Class c = NSClassFromString(controllerClassName);
            if (c) {
                NSMutableDictionary* dicParams = [NSMutableDictionary dictionaryWithDictionary:routerParameters];
                [dicParams removeObjectForKey:schemaController];
                [dicParams removeObjectForKey:MGJRouterParameterURL];
                [dicParams removeObjectForKey:MGJRouterParameterCompletion];
                [dicParams removeObjectForKey:MGJRouterParameterUserInfo];
                UIViewController* vc = [[c alloc] init];
                if (dicParams.count > 0) {
                    for (NSString* key in dicParams.allKeys) {
                        [vc setValue:dicParams[key] forKey:key];
                    }
                }
                [JxbPushManager pushController:vc];
            }
        }
    }];
}

+ (void)regiserUrl:(NSString*)schemaUrl toHandler:(void(^)(NSDictionary* parameters))toHandler {
    [MGJRouter registerURLPattern:schemaUrl toHandler:toHandler];
}

+ (BOOL)openUrl:(NSURL*)url {
    return [self openUrl:url withParameters:nil];
}

+ (BOOL)openUrl:(NSURL *)url withParameters:(NSDictionary *)parameters {
    BOOL canOpen = [MGJRouter canOpenURL:url.absoluteString];
    if (!canOpen) return canOpen;
    [MGJRouter openURL:url.absoluteString withUserInfo:parameters completion:nil];
    return YES;
}
@end
