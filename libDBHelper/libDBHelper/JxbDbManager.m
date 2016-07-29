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
        NSString* dir = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/JxbDb"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:dir]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSURL* url = [NSURL URLWithString:[dir stringByAppendingPathComponent:@"db.realm"]];
        NSLog(@"%@",url.absoluteString);
        _realm = [RLMRealm realmWithURL:url];
    }
    return self;
}

- (void)insert:(id)obj {
   [self update:obj];
}

- (void)inserts:(NSArray *)objs {
    [self updates:objs];
}

- (void)update:(id)obj {
    __weak typeof (self) wSelf = self;
    [self.realm transactionWithBlock:^{
        [wSelf.realm addOrUpdateObject:(RLMObject*)obj];
    }];
}

- (void)updates:(NSArray *)objs {
    __weak typeof (self) wSelf = self;
    [self.realm transactionWithBlock:^{
        [wSelf.realm addOrUpdateObjectsFromArray:objs];
    }];
}

- (void)remove:(NSString *)tableName primaryValue:(NSString *)primaryValue {
    __weak typeof (self) wSelf = self;
    Class cls = NSClassFromString(tableName);
    NSString* pk = [cls performSelector:@selector(primaryKey)];
    RLMResults* result = [cls objectsInRealm:wSelf.realm where:[NSString stringWithFormat:@"%@='%@'",pk,primaryValue]];
    [self.realm transactionWithBlock:^{
        [wSelf.realm deleteObject:result.firstObject];
    }];
}

- (void)select:(NSString *)tableName where:(NSString *)where {
    [self select:tableName where:where sortProperty:nil ascending:false];
}

- (void)select:(NSString *)tableName where:(NSString *)where sortProperty:(NSString *)sortProperty ascending:(BOOL)ascending {
    [self select:tableName where:where propertys:@[[RLMSortDescriptor sortDescriptorWithProperty:sortProperty ascending:ascending]]];
}

- (void)select:(NSString *)tableName where:(NSString *)where propertys:(NSArray *)propertys {
    __weak typeof (self) wSelf = self;
    Class cls = NSClassFromString(tableName);
    RLMResults* result = nil;
    if (where && where.length > 0) {
        result = [cls objectsInRealm:wSelf.realm where:where];
    }
    else {
        result = [cls allObjectsInRealm:wSelf.realm];
    }
    if (propertys && propertys.count > 0) {
        result = [result sortedResultsUsingDescriptors:propertys];
    }
}

- (void)select:(NSString *)tableName predicate:(NSPredicate *)predicate {
    [self select:tableName predicate:predicate propertys:nil];
}

- (void)select:(NSString *)tableName predicate:(NSPredicate *)predicate sortProperty:(NSString *)sortProperty ascending:(BOOL)ascending {
    [self select:tableName predicate:predicate propertys:@[[RLMSortDescriptor sortDescriptorWithProperty:sortProperty ascending:ascending]]];
}

- (void)select:(NSString *)tableName predicate:(NSPredicate *)predicate propertys:(NSArray *)propertys {
    __weak typeof (self) wSelf = self;
    Class cls = NSClassFromString(tableName);
    RLMResults* result = nil;
    if (predicate) {
        result = [cls objectsInRealm:wSelf.realm withPredicate:predicate];
    }
    else {
        result = [cls allObjectsInRealm:wSelf.realm];
    }
    if (propertys && propertys.count > 0) {
        result = [result sortedResultsUsingDescriptors:propertys];
    }
}
@end
