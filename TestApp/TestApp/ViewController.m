//
//  ViewController.m
//  TestApp
//
//  Created by Peter on 16/7/20.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "ViewController.h"
#import <libRouter/libRouter.h>
#import <UIBase/UIBase.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSMutableArray* arrSection = [NSMutableArray array];
   
    NSMutableArray* arrCell = [NSMutableArray array];
    
    JxbTableViewCellModel* cell1 = [[JxbTableViewCellModel alloc] init];
    cell1.height = 100;
    cell1.BlockCell = ^(NSIndexPath*  indexPath, UITableView*  table) {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        cell.textLabel.text = @"测试";
        return cell;
    };
    [arrCell addObject:cell1];
    
    JxbTableViewSectionModel* section1 = [[JxbTableViewSectionModel alloc] init];
    section1.cellModelArray = arrCell;
    
    JxbTableHeadorFootModel* head = [[JxbTableHeadorFootModel alloc] init];
    head.height = 20;
    head.block = ^(NSInteger section, UITableView *table) {
        UIView* vvv = [[UIView alloc] init];
        vvv.backgroundColor = [UIColor greenColor];
        return vvv;
    };
    section1.header = head;
    
    [arrSection addObject:section1];
    
    
    JxbTableView* tableview = [JxbTableView createTableView];
    tableview.backgroundColor = [UIColor redColor];
    tableview.frame = self.view.bounds;
    tableview.arraySections = arrSection;
    [self.view addSubview:tableview];
    
//    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//    [self.view addGestureRecognizer:tap];
//    
//    
//    [JxbRouterManager registerCommonPush:@"testApp"];
}

- (void)tapAction {
//    [[[UIAlertView alloc] initWithTitle:@"1" message:@"2" delegate:nil cancelButtonTitle:@"3" otherButtonTitles:@"4", nil] show];
    
    //[self.navigationController pushViewController:[ViewController new] animated:YES];
    
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"testApp://NaviPush/Test1ViewController?sid=123"]];
    
}

@end
