//
//  UIView+FindFirstResponder.m
//  Tripinsiders
//
//  Created by ZhouQian on 16/5/7.
//  Copyright © 2016年 Tripinsiders. All rights reserved.
//

#import "UIView+FindFirstResponder.h"

@implementation UIView (FindFirstResponder)
- (id)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        id responder = [subView findFirstResponder];
        if (responder) return responder;
    }
    return nil;
}
@end
