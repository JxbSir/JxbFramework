//
//  JxbBaseVC.h
//  UIBase
//
//  Created by Peter on 16/7/22.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JxbBaseUIProtocol <NSObject>
@optional
/**
 *  初始化UI
 */
- (void)Jxb_InitalUI;

/**
 *  初始化AutoLayout or Frame
 */
- (void)Jxb_SetLayouts;

/**
 *  初始化Kvo监控
 */
- (void)Jxb_BeginKvo;

/**
 *  加载数据
 */
- (void)Jxb_Loaddata;
@end

@interface JxbBaseVC : UIViewController<JxbBaseUIProtocol>

#pragma mark UI related properties & functions
@property (nonatomic, assign) BOOL     showBackBtn;
@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, strong) UIButton *navLeftBtn;
@property (nonatomic, strong) UIButton *navRightBtn;


/**
 *  left or right action
 *
 *  @param nrlImage
 *  @param hltImage
 *  @param title
 *  @param btnClickBlock
 */
- (void)actionCustomLeftBtnWithNrlImage:(NSString *)nrlImage htlImage:(NSString *)hltImage
                                  title:(NSString *)title
                                 action:(void(^)())btnClickBlock;

/**
 *  left or right action
 *
 *  @param nrlImage
 *  @param hltImage
 *  @param title
 *  @param btnClickBlock
 */
- (void)actionCustomRightBtnWithNrlImage:(NSString *)nrlImage htlImage:(NSString *)hltImage
                                   title:(NSString *)title
                                  action:(void(^)())btnClickBlock;
@end
