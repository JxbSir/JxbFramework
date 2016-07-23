//
//  UITextField+ExtentRange.h
//  TP
//
//  Created by Peter on 15/11/27.
//  Copyright © 2015年 VizLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ExtentRange)

- (NSRange) selectedRange;
- (void) setSelectedRange:(NSRange) range;
@end
