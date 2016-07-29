//
//  TestDB.h
//  TestApp
//
//  Created by Peter on 16/7/27.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libDBHelper/libDBHelper.h>

@interface TestDB : JxbDbObject

@property (nonatomic, strong) NSString  *pid;
@property (nonatomic, strong) NSString  *aaa;
@property (nonatomic, strong) NSString  *bbb;
@end
