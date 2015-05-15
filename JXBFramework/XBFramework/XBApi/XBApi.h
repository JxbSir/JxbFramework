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

+ (instancetype)SharedXBApi:(AFHTTPResponseSerializer*)respone;

- (void)requestWithURL:(NSString *)url
                 paras:(NSDictionary *)parasDict
                  type:(XBHttpResponseType)type
               success:(void(^)(AFHTTPRequestOperation* operation, NSObject *resultObject))success
               failure:(void(^)(NSError *requestErr))failure ;

- (NSObject*)requestSyncWithURL:(NSString *)url
                     paras:(NSDictionary *)parasDict
                      type:(XBHttpResponseType)type;
@end
