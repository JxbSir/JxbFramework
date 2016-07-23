//
//  NSString+RegExp.h
//  Tripinsiders
//
//  Created by ZhouQian on 16/5/5.
//  Copyright © 2016年 Tripinsiders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegExp)
- (BOOL)validateWithRegExp:(NSString *)regExp;
@end
