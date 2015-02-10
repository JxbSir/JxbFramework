//
//  XBHttpClient.h
//  XBHttpClient
//
//  Created by Peter on 15/1/30.
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum
{
    XBHttpResponseType_Json,
    XBHttpResponseType_XML,
    XBHttpResponseType_Common
}XBHttpResponseType;

@interface XBHttpClient : AFHTTPRequestOperationManager


- (void)requestWithURL:(NSString *)url
                 paras:(NSDictionary *)parasDict
                  type:(XBHttpResponseType)type
               success:(void(^)(NSObject *resultObject))success
               failure:(void(^)(NSError *requestErr))failure ;

@end
