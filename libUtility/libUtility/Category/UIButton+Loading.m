//
//  UIButton+Loading.m
//  TP
//
//  Created by Peter on 15/12/16.
//  Copyright © 2015年 VizLab. All rights reserved.
//

#import "UIButton+Loading.h"
#import <objc/runtime.h>

@implementation UIButton (Loading)

- (NSNumber*)isOperationing {
    return objc_getAssociatedObject(self, @"isOperationing");
}

- (void)setIsOperationing:(NSNumber*)b {
    objc_setAssociatedObject(self, @"isOperationing", b, OBJC_ASSOCIATION_ASSIGN);
}

- (void)start {
    self.isOperationing = @(1);
    [self setTitle:@"" forState:UIControlStateDisabled];
    self.enabled = NO;
    
    UIActivityIndicatorView* actIndi = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 16, self.frame.size.height / 2 - 16, 32, 32)];
    [self addSubview:actIndi];
    [actIndi startAnimating];
   
}

- (void)end {
    self.isOperationing = @(0);
    self.enabled = YES;
    for (NSObject* v in self.subviews) {
        if ([v isKindOfClass:[UIActivityIndicatorView class]]) {
            UIActivityIndicatorView* vvv = (UIActivityIndicatorView*)v;
            [vvv stopAnimating];
            [vvv removeFromSuperview];
        }
    }
}
@end
