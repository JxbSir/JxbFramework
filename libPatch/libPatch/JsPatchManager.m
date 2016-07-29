//
//  JsPatchManager.m
//  JsPatch
//
//  Created by Peter on 16/7/20.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JsPatchManager.h"
#import <JSPatch/JPEngine.h>
#import <JSPatch/JSPatch.h>

@interface JsPatchManager ()
@property (nonatomic, strong) dispatch_queue_t  queueDownload;
@end

@implementation JsPatchManager

+ (instancetype)shareInstance {
    static JsPatchManager   *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JsPatchManager alloc] init];
    });
    return manager;
}

#pragma mark - 官方补丁
+ (void)startPatch:(NSString*)appKey {
    [self startPatch:appKey publicKey:nil];
}

+ (void)startPatch:(NSString*)appKey publicKey:(NSString*)publicKey {
    [self startPatch:appKey publicKey:publicKey bDevelopment:NO];
}

+ (void)startPatch:(NSString*)appKey publicKey:(NSString*)publicKey bDevelopment:(BOOL)bDevelopment {
    [JSPatch setupCallback:^(JPCallbackType type, NSDictionary *data, NSError *error) {
        //回调
    }];
    [JSPatch startWithAppKey:appKey];
    if (publicKey && publicKey.length > 0) {
        [JSPatch setupRSAPublicKey:publicKey];
    }
    if (bDevelopment) {
#if DEBUG
        [JSPatch setupDevelopment];
#endif
    }
    [JSPatch sync];
}

#pragma mark - 自己下载逻辑
- (dispatch_queue_t)queueDownload {
    if (!_queueDownload) {
        _queueDownload = dispatch_queue_create("com.Jspatch.manager.download.creation", DISPATCH_QUEUE_SERIAL);
    }
    return _queueDownload;
}

- (void)downloadJsPatch:(NSArray *)urls {
    __weak typeof (self) wSelf = self;
    [JPEngine startEngine];
    for (int i = 0; i < urls.count; i++) {
        NSURL* url = urls[i];
        dispatch_async(self.queueDownload, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (wSelf.delegate && [wSelf.delegate respondsToSelector:@selector(jsPathDownload:)]) {
                    [wSelf.delegate jsPathDownload:1.0*(i+1)/urls.count];
                }
            });
            __block dispatch_semaphore_t sem = dispatch_semaphore_create(0);
            NSURLSessionTask* task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (!error && data) {
                    NSString *jsContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    [JPEngine evaluateScript:jsContent];
                }
                dispatch_semaphore_signal(sem);
            }];
            [task resume];
            dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        });
    }

}

- (void)excuteJsPatch:(NSArray *)jsContents {
    [JPEngine startEngine];
    for (NSString* content in jsContents) {
        [JPEngine evaluateScript:content];
    }
}

@end
