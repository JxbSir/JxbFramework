//
//  XBDbVersionTable.h
//  OneYuan
//
//  Created by Peter on 15/2/26.
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBDbVersionTable : NSObject
@property(nonatomic,copy)NSString* tablename;
@property(nonatomic,copy)NSNumber* version;
@end
