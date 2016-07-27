//
//  JxbDbManager.m
//  libDBHelper
//
//  Created by Peter on 16/7/27.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbDbManager.h"
#import <Realm/Realm.h>
#import <objc/runtime.h>

@interface JxbDbManager()
@property (nonatomic, strong) RLMRealm *realm;
@end

@implementation JxbDbManager

+ (instancetype)sharedInstance {
    static JxbDbManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JxbDbManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
        NSString* dir = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/JxbDb"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:dir]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSURL* url = [NSURL URLWithString:[dir stringByAppendingPathComponent:@"db.realm"]];
        NSLog(@"%@",url.absoluteString);
        configuration.fileURL = url;
        [RLMRealmConfiguration setDefaultConfiguration:configuration];
        _realm = [RLMRealm realmWithURL:url];
    }
    return self;
}

- (void)add2Db:(NSObject*)obj {
    __weak typeof (self) wSelf = self;
    [self.realm transactionWithBlock:^{
        [wSelf.realm addObject:obj];
    }];
}
@end
