//
//  ViewController.m
//  JxbFramework
//
//  Created by Peter on 16/1/14.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "ViewController.h"
#import "XBFramework.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString* url = @"http://42.121.16.186:8888/baseservice/getUserInfo";
    NSDictionary* dicParas = @{@"custVersion":@"1.0.1", @"phoneType":@"ios"};
   
    [[XBApi SharedXBApi] requestWithURL:url paras:dicParas type:XBHttpResponseType_Json success:^(NSURLSessionDataTask *task, NSObject *resultObject) {
        
    } failure:^(NSError *requestErr) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
