//
//  JxbWKWebView.m
//  libBaseUI
//
//  Created by Peter on 16/8/19.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbWKWebView.h"

@interface JxbWKWebView()
@property (nonatomic, strong) UIView        *webProgress;
@end

@implementation JxbWKWebView

#pragma mark - Life cycle        / 生命周期
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame configuration:[self getWKConfiguration]];
    if (self) {
        self.navigationDelegate = self;
        [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [self initUIS];
    }
    return self;
}

#pragma mark - Inital UI         / 初始化界面
- (void)initUIS {
    [self addSubview:self.webProgress];
}

#pragma mark - Loading data      / 加载数据
#pragma mark - UITableViewModel  / 创建TableView模型
#pragma mark - SystemDelegate    / 系统代理
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([navigationAction.request.URL.scheme isEqualToString:self.scheme]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
    }
    else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if (self.dicActions && self.dicActions[message.name] != NULL) {
        JxbWkAction block = self.dicActions[message.name];
        block(message.body);
    }
}

#pragma mark - CustomDelegate    / 自定义代理
#pragma mark - Observer          / KVO监控
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        __weak typeof (self) wSelf = self;
        self.webProgress.alpha = 1;
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        self.webProgress.frame = CGRectMake(0, 0, self.bounds.size.width * [change[@"new"] floatValue], wSelf.heightOfProcess);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                wSelf.webProgress.alpha = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                wSelf.webProgress.frame = CGRectMake(0, 0, 0, wSelf.heightOfProcess);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Enent response    / 事件响应
#pragma mark - Private methods   / 私有函数
#pragma mark - Setter and getter / get与set函数
- (WKWebViewConfiguration *)getWKConfiguration {
    WKWebViewConfiguration *config=[[WKWebViewConfiguration alloc] init];
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc] init];
    return config;
}

- (UIView*)webProgress {
    if (!_webProgress) {
        _webProgress = [[UIView alloc] init];
    }
    return _webProgress;
}

- (void)setColorOfProcess:(UIColor *)colorOfProcess {
    _colorOfProcess = colorOfProcess;
    self.webProgress.backgroundColor = colorOfProcess;
}

- (CGFloat)heightOfProcess {
    if (_heightOfProcess == 0) {
        return 1;
    }
    return _heightOfProcess;
}

- (void)setDicActions:(NSDictionary *)dicActions {
    _dicActions = dicActions;
    if (dicActions.count > 0) {
        for (NSString* key in dicActions.allKeys) {
            [self.configuration.userContentController addScriptMessageHandler:self name:key];
        }
    }
}
@end
