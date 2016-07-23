//
//  Test1ViewController.m
//  TestApp
//
//  Created by Peter on 16/7/22.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "Test1ViewController.h"

@interface Test1ViewController ()

@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"test1";
    NSLog(@"sid:%@",self.sid);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
