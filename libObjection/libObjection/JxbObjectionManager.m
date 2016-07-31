//
//  JxbObjectionManager.m
//  libObjection
//
//  Created by Peter on 16/7/31.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbObjectionManager.h"
#import "JSObjection.h"
#import "JSObjectionModule.h"
#import "JSObjectionInjector.h"

@interface JxbObjectionManager()
@property (nonatomic, strong) JSObjectionInjector   *injector;
@property (nonatomic, strong) JSObjectionModule     *module;
@end

@implementation JxbObjectionManager

+ (instancetype)shareInstance {
    static JxbObjectionManager   *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JxbObjectionManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.injector = [JSObjection defaultInjector];
        self.injector = self.injector ? : [JSObjection createInjector];
        [JSObjection setDefaultInjector:self.injector];
    }
    return self;
}

- (void)bindInstance:(id)obj toProtocol:(Protocol *)toProtocol {
    [self bindInstance:obj toProtocol:toProtocol forName:nil];
}

- (void)bindInstance:(id)obj toProtocol:(Protocol *)toProtocol forName:(NSString *)forName {
    [self.module bind:obj toProtocol:toProtocol named:forName];
    self.injector = [self.injector withModule:self.module];
}

- (void)bindClass:(Class)cls toProtocol:(Protocol *)toProtocol {
    [self bindClass:cls toProtocol:toProtocol forName:nil];
}

- (void)bindClass:(Class)cls toProtocol:(Protocol *)toProtocol forName:(NSString *)forName {
    [self.module bindClass:cls toProtocol:toProtocol named:forName];
    self.injector = [self.injector withModule:self.module];
}

- (id)getObject:(Protocol *)fromProtocol {
    return [self getObject:fromProtocol orName:nil];
}

- (id)getObject:(Protocol *)fromProtocol orName:(NSString *)forName {
    id obj = [self.injector getObject:fromProtocol named:forName];
    return obj;
}

- (JSObjectionModule *)module {
    if (!_module) {
        _module = [[JSObjectionModule alloc] init];
    }
    return _module;
}
@end
