//
//  JxbWKWebView.h
//  TripBaseUI
//
//  Created by Peter on 16/8/19.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <WebKit/WebKit.h>

typedef void(^JxbWkAction)(id _Nullable body);

@interface JxbWKWebView : WKWebView

/**
 *  本App的scheme名称，例：testApp://about, 则传testApp
 *  若不传此参数，scheme不会生效
 */
@property (nonatomic, copy  ) NSString * _Nullable  scheme;

/**
 *  网页加载的进度显示，若不传，则不显示进度
 */
@property (nonatomic, strong) UIColor  * _Nullable  colorOfProcess;

/**
 *  网页加载进度条的高度
 */
@property (nonatomic, assign) CGFloat      heightOfProcess;

/**
 *  Js调用原生函数操作集合
 *  key：对象名称,window.webkit.messageHandlers.OOXX.postMessage(),OOXX就是key
 *  执行block:JxbWkAction，入参为id，自行转需要的数据
 */
@property (nonatomic, strong) NSDictionary * _Nullable dicActions;

@end
