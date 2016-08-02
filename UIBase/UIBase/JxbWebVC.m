//
//  JxbWebVC
//  UIBase
//
//  Created by Peter on 16/8/1.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbWebVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JxbWebProtocol <JSExport>
/**
 *  JS与OC桥接协议
 *
 *  @param operationName    执行函数名称
 *  @param paramsNum        后面接收参数个数（必须一致）
 */
- (void)operationAction:(NSString *)operationName paramsNum:(NSNumber *)paramsNum, ...;
@end

@interface JxbWebVC()<UIWebViewDelegate,JxbWebProtocol>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, weak  ) JSContext *jsContext;
@end

@implementation JxbWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.itemTitle = self.naviTitle;
    [self setShowBackBtn:YES];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.gotoUrl]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (self.jsBridgeName && self.jsBridgeName.length > 0) {
        self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        self.jsContext[self.jsBridgeName] = self;
        self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
            context.exception = exceptionValue;
            NSLog(@"异常信息：%@", exceptionValue);
        };
    }
}

- (void)operationAction:(NSString *)operationName paramsNum:(NSNumber *)paramsNum, ... {
    JxbWebAction action = self.dicOperationBlock[operationName];
    NSMutableArray *argsArray = nil;
    if (paramsNum.integerValue > 0) {
        argsArray = [[NSMutableArray alloc] init];
        va_list params; //定义一个指向个数可变的参数列表指针;
        va_start(params,paramsNum);//va_start 得到第一个可变参数地址,
        id arg;
        if (paramsNum) {
            //va_arg 指向下一个参数地址
            //这里是问题的所在 网上的例子，没有保存第一个参数地址，后边循环，指针将不会在指向第一个参数
            while( (arg = va_arg(params,id)) )
            {
                if ( arg ){
                    [argsArray addObject:arg];
                    if (argsArray.count >= paramsNum.integerValue)
                        break;
                }
            }  
            //置空  
            va_end(params);
        }
    }
    if (action != NULL) {
        action(operationName, argsArray);
    }
}
@end
