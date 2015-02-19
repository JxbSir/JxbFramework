//
//  XBApi.h
//  XBHttpClient
//
//  Created by Peter on 15/1/30.
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBHttpClient.h"

#define kXBCookie   @"kXBCookie"


#define kHttpAllowSaveCache    @"http_a_s_c"
#define kHttpAllowFetchCache   @"http_a_f_c"

@interface XBApi : NSObject

+ (instancetype)SharedXBApi;

- (void)requestWithURL:(NSString *)url
                 paras:(NSDictionary *)parasDict
                  type:(XBHttpResponseType)type
               success:(void(^)(AFHTTPRequestOperation* operation, NSObject *resultObject))success
               failure:(void(^)(NSError *requestErr))failure ;
@end
