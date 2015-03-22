//
//  XBBaseTabVC.h
//  JXBFramework
//
//  Created by Peter on 15/3/22.
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBBaseTabItem : NSObject
@property(nonatomic,copy)NSString   *title;
@property(nonatomic,copy)NSString   *selectedImage;
@property(nonatomic,copy)NSString   *unselectedImage;
@property(nonatomic,strong)XBBaseVC   *rootVC;
@end

@interface XBBaseTabVC : UITabBarController
- (XBBaseTabVC*)initWithItems:(NSArray*)items;
@end
