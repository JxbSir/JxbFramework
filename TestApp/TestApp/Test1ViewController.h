//
//  Test1ViewController.h
//  TestApp
//
//  Created by Peter on 16/7/22.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol testProtocol <NSObject>

@end

@interface Test1ViewController : UIViewController<testProtocol>

@property (nonatomic, strong) NSString  *sid;

@end
