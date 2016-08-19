//
//  JxbWebVC
//  UIBase
//
//  Created by Peter on 16/8/1.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JxbBaseVC.h"

typedef void(^JxbWebAction)(NSString* actionName, NSArray* params);

@interface JxbWebVC : JxbBaseVC

/**
 *  导航栏标题
 */
@property (nonatomic, strong) NSString      *naviTitle;

/**
 *  跳转的Url地址
 */
@property (nonatomic, strong) NSURL         *gotoUrl;

/**
 *  Js的桥梁名称
 */
@property (nonatomic, strong) NSString      *jsBridgeName;

/**
 *  JS调用OC原生函数block字典
 */
@property (nonatomic, strong) NSDictionary  *dicOperationBlock;

@end
