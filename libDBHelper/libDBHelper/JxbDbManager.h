//
//  JxbDbManager.h
//  libDBHelper
//
//  Created by Peter on 16/7/27.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JxbDbManager : NSObject

+ (instancetype)sharedInstance;

- (void)add2Db:(NSObject*)obj;
@end
