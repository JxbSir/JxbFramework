//
//  LoginParser.h
//  JXBFramework
//
//  Created by Peter Jin @ https://github.com/JxbSir on 15/2/10.
//  Copyright (c) 2015年 Mail:i@Jxb.name. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginParser2 : XBParser
@property(nonatomic,copy)NSString* phoneType;
@end

@interface LoginParser : XBParser
@property(nonatomic,strong)LoginParser2* data;
@property(nonatomic,copy)NSString* errorCode;
@property(nonatomic,copy)NSString* errorMsg;
@property(nonatomic,copy)NSNumber* success;
@end
