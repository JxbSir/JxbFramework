//
//  ViewController.m
//  TestApp
//
//  Created by Peter on 16/7/20.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "ViewController.h"
#import <libRouter/libRouter.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    
    [libRouterManager registerCommonPush:@"testApp"];
}

- (void)tapAction {
//    [[[UIAlertView alloc] initWithTitle:@"1" message:@"2" delegate:nil cancelButtonTitle:@"3" otherButtonTitles:@"4", nil] show];
    
    //[self.navigationController pushViewController:[ViewController new] animated:YES];
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"testApp://NaviPush/Test1ViewController?sid=123"]];
    
}

@end
