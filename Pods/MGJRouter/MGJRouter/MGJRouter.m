//
//  MGJRouter.m
//  MGJFoundation
//
//  Created by limboy on 12/9/14.
//  Copyright (c) 2014 juangua. All rights reserved.
//

#import "MGJRouter.h"
#import <objc/runtime.h>

static NSString * const MGJ_ROUTER_WILDCARD_CHARACTER = @"~";

NSString *const MGJRouterParameterURL = @"MGJRouterParameterURL";
NSString *const MGJRouterParameterCompletion = @"MGJRouterParameterCompletion";
NSString *const MGJRouterParameterUserInfo = @"MGJRouterParameterUserInfo";

@interface MGJRouter ()
/**
 *  保存了所有已注册的 URL
 *  结构类似 @{@"beauty": @{@":id": {@"_", [block copy]}}}
 */
@property (nonatomic) NSMutableDictionary *routes;
@end

@implementation MGJRouter

+ (instancetype)sharedIsntance
{
    static MGJRouter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)registerURLPattern:(NSString *)URLPattern toHandler:(MGJRouterHandler)handler
{
    [[self sharedIsntance] addURLPattern:URLPattern andHandler:handler];
}

+ (void)deregisterURLPattern:(NSString *)URLPattern
{
    [[self sharedIsntance] removeURLPattern:URLPattern];
}

+ (void)openURL:(NSString *)URL
{
    [self openURL:URL completion:nil];
}

+ (void)openURL:(NSString *)URL completion:(void (^)(id result))completion
{
    [self openURL:URL withUserInfo:nil completion:completion];
}

+ (void)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion
{
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *parameters = [[self sharedIsntance] extractParametersFromURL:URL];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, NSString *obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            parameters[key] = [obj stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }];
    
    if (parameters) {
        MGJRouterHandler handler = parameters[@"block"];
        if (completion) {
            parameters[MGJRouterParameterCompletion] = completion;
        }
        if (userInfo) {
            parameters[MGJRouterParameterUserInfo] = userInfo;
        }
        if (handler) {
            [parameters removeObjectForKey:@"block"];
            handler(parameters);
        }
    }
}

+ (BOOL)canOpenURL:(NSString *)URL
{
    return [[self sharedIsntance] extractParametersFromURL:URL] ? YES : NO;
}

+ (NSString *)generateURLWithPattern:(NSString *)pattern parameters:(NSArray *)parameters
{
    NSInteger startIndexOfColon = 0;
    NSMutableArray *items = [[NSMutableArray alloc] init];
    NSInteger parameterIndex = 0;
    
    for (int i = 0; i < pattern.length; i++) {
        NSString *character = [NSString stringWithFormat:@"%c", [pattern characterAtIndex:i]];
        if ([character isEqualToString:@":"]) {
            startIndexOfColon = i;
        }
        if (([@[@"/", @"?", @"&"] containsObject:character] || (i == pattern.length - 1 && startIndexOfColon) ) && startIndexOfColon) {
            if (i > (startIndexOfColon + 1)) {
                [items addObject:[NSString stringWithFormat:@"%@%@", [pattern substringWithRange:NSMakeRange(0, startIndexOfColon)], parameters[parameterIndex++]]];
                pattern = [pattern substringFromIndex:i];
                i = 0;
            }
            startIndexOfColon = 0;
        }
    }
    
    return [items componentsJoinedByString:@""];
}

+ (id)objectForURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo
{
    MGJRouter *router = [MGJRouter sharedIsntance];
    
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *parameters = [router extractParametersFromURL:URL];
    MGJRouterObjectHandler handler = parameters[@"block"];
    
    if (handler) {
        if (userInfo) {
            parameters[MGJRouterParameterUserInfo] = userInfo;
        }
        [parameters removeObjectForKey:@"block"];
        return handler(parameters);
    }
    return nil;
}

+ (id)objectForURL:(NSString *)URL
{
    return [self objectForURL:URL withUserInfo:nil];
}

+ (void)registerURLPattern:(NSString *)URLPattern toObjectHandler:(MGJRouterObjectHandler)handler
{
    [[self sharedIsntance] addURLPattern:URLPattern andObjectHandler:handler];
}

- (void)addURLPattern:(NSString *)URLPattern andHandler:(MGJRouterHandler)handler
{
    NSMutableDictionary *subRoutes = [self addURLPattern:URLPattern];
    if (handler && subRoutes) {
        subRoutes[@"_"] = [handler copy];
    }
}

- (void)addURLPattern:(NSString *)URLPattern andObjectHandler:(MGJRouterObjectHandler)handler
{
    NSMutableDictionary *subRoutes = [self addURLPattern:URLPattern];
    if (handler && subRoutes) {
        subRoutes[@"_"] = [handler copy];
    }
}

- (NSMutableDictionary *)addURLPattern:(NSString *)URLPattern
{
    NSArray *pathComponents = [self pathComponentsFromURL:URLPattern];
    
    NSInteger index = 0;
    NSMutableDictionary* subRoutes = self.routes;
    
    while (index < pathComponents.count) {
        NSString* pathComponent = pathComponents[index];
        if (![subRoutes objectForKey:pathComponent]) {
            subRoutes[pathComponent] = [[NSMutableDictionary alloc] init];
        }
        subRoutes = subRoutes[pathComponent];
        index++;
    }
    return subRoutes;
}

#pragma mark - Utils

- (NSMutableDictionary *)extractParametersFromURL:(NSString *)url
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    
    parameters[MGJRouterParameterURL] = url;
    
    NSMutableDictionary* subRoutes = self.routes;
    NSArray* pathComponents = [self pathComponentsFromURL:url];
    
    // borrowed from HHRouter(https://github.com/Huohua/HHRouter)
    for (NSString* pathComponent in pathComponents) {
        BOOL found = NO;
        
        // 对 key 进行排序，这样可以把 ~ 放到最后
        NSArray *subRoutesKeys =[subRoutes.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            return [obj1 compare:obj2];
        }];
        
        for (NSString* key in subRoutesKeys) {
            if ([key isEqualToString:pathComponent] || [key isEqualToString:MGJ_ROUTER_WILDCARD_CHARACTER]) {
                found = YES;
                subRoutes = subRoutes[key];
                break;
            } else if ([key hasPrefix:@":"]) {
                found = YES;
                subRoutes = subRoutes[key];
                parameters[[key substringFromIndex:1]] = pathComponent;
                break;
            }
        }
        // 如果没有找到该 pathComponent 对应的 handler，则以上一层的 handler 作为 fallback
        if (!found && !subRoutes[@"_"]) {
            return nil;
        }
    }
    
    // Extract Params From Query.
    NSArray* pathInfo = [url componentsSeparatedByString:@"?"];
    if (pathInfo.count > 1) {
        NSString* parametersString = [pathInfo objectAtIndex:1];
        NSArray* paramStringArr = [parametersString componentsSeparatedByString:@"&"];
        for (NSString* paramString in paramStringArr) {
            NSArray* paramArr = [paramString componentsSeparatedByString:@"="];
            if (paramArr.count > 1) {
                NSString* key = [paramArr objectAtIndex:0];
                NSString* value = [paramArr objectAtIndex:1];
                parameters[key] = value;
            }
        }
    }
    
    if (subRoutes[@"_"]) {
        parameters[@"block"] = [subRoutes[@"_"] copy];
    }
    
    return parameters;
}

- (void)removeURLPattern:(NSString *)URLPattern
{
    NSMutableArray *pathComponents = [NSMutableArray arrayWithArray:[self pathComponentsFromURL:URLPattern]];
    
    // 只删除该 pattern 的最后一级
    if (pathComponents.count >= 1) {
        // 假如 URLPattern 为 a/b/c, components 就是 @"a.b.c" 正好可以作为 KVC 的 key
        NSString *components = [pathComponents componentsJoinedByString:@"."];
        NSMutableDictionary *route = [self.routes valueForKeyPath:components];
        
        if (route.count >= 1) {
            NSString *lastComponent = [pathComponents lastObject];
            [pathComponents removeLastObject];
            
            // 有可能是根 key，这样就是 self.routes 了
            route = self.routes;
            if (pathComponents.count) {
                NSString *componentsWithoutLast = [pathComponents componentsJoinedByString:@"."];
                route = [self.routes valueForKeyPath:componentsWithoutLast];
            }
            [route removeObjectForKey:lastComponent];
        }
    }
}

- (NSArray*)pathComponentsFromURL:(NSString*)URL
{
    NSMutableArray *pathComponents = [NSMutableArray array];
    if ([URL rangeOfString:@"://"].location != NSNotFound) {
        NSArray *pathSegments = [URL componentsSeparatedByString:@"://"];
        // 如果 URL 包含协议，那么把协议作为第一个元素放进去
        [pathComponents addObject:pathSegments[0]];
        
        // 如果只有协议，那么放一个占位符
        if ((pathSegments.count == 2 && ((NSString *)pathSegments[1]).length) || pathSegments.count < 2) {
            [pathComponents addObject:MGJ_ROUTER_WILDCARD_CHARACTER];
        }
        
        URL = [URL substringFromIndex:[URL rangeOfString:@"://"].location + 3];
    }
    
    for (NSString *pathComponent in [[NSURL URLWithString:URL] pathComponents]) {
        if ([pathComponent isEqualToString:@"/"]) continue;
        if ([[pathComponent substringToIndex:1] isEqualToString:@"?"]) break;
        [pathComponents addObject:pathComponent];
    }
    return [pathComponents copy];
}

- (NSMutableDictionary *)routes
{
    if (!_routes) {
        _routes = [[NSMutableDictionary alloc] init];
    }
    return _routes;
}

@end
