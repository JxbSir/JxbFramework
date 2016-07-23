//
//  UIView+FindUIViewController.h
//  TP
//
//  Created by ZhouQian on 16/3/23.
//  Copyright © 2016年 Tripinsiders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FindUIViewController)
- (UIViewController *) firstAvailableUIViewController;
- (id) traverseResponderChainForUIViewController;
@end
