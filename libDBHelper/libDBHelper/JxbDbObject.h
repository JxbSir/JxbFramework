//
//  JxbDbObject.h
//  libDBHelper
//
//  Created by Peter on 16/7/27.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JxbDbObject : NSObject

+ (id)registerForRealmObject:(NSString*)className withProtocol:(Protocol*)protocol;
@end
