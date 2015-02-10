//
//  XBApi.h
//  XBHttpClient
//
//  Created by Peter on 15/1/30.
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBHttpClient.h"

@interface XBApi : NSObject

+ (instancetype)SharedXBApi;

- (void)requestWithURL:(NSString *)url
                 paras:(NSDictionary *)parasDict
                  type:(XBHttpResponseType)type
               success:(void(^)(NSObject *resultObject))success
               failure:(void(^)(NSError *requestErr))failure ;
@end
