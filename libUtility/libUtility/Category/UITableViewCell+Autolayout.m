//
//  UITableViewCell+Autolayout.m
//  TP
//
//  Created by Peter on 15/11/18.
//  Copyright © 2015年 VizLab. All rights reserved.
//

#import "UITableViewCell+Autolayout.h"

@implementation UITableViewCell (Autolayout)

- (void)setSelfAutolayout:(UIView *)view bottom:(CGFloat)bottom {
    [view setNeedsLayout];
    [view layoutIfNeeded];
    CGRect r = self.frame;
    r.size.height = view.frame.origin.y+view.frame.size.height + bottom;
    self.frame = r;
}
@end
