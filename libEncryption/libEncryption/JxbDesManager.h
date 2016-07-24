//
//  JxbDesManager.h
//  libEncryption
//
//  Created by Peter on 16/7/24.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JxbDesManager : NSObject

+ (NSString *)encrypt:(NSString *)key plainText:(NSString *)plainText;
+ (NSString *)decrypt:(NSString *)key plainText:(NSString *)cipherText;
@end
