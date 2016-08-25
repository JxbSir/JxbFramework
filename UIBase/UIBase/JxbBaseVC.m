//
//  JxbBaseVC.m
//  UIBase
//
//  Created by Peter on 16/7/22.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbBaseVC.h"
#import <objc/runtime.h>

static char *btnClickAction;

@interface JxbBaseVC ()<UIGestureRecognizerDelegate>

@end

@implementation JxbBaseVC

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    id viewController = [super allocWithZone:zone];
    return viewController;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}


- (id)init {
    if (self = [super init]) {
        if ([self respondsToSelector:@selector(setExtendedLayoutIncludesOpaqueBars:)])
        {
            self.extendedLayoutIncludesOpaqueBars = NO;
        }
        if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        if([self respondsToSelector:@selector(setModalPresentationCapturesStatusBarAppearance:)])
        {
            self.modalPresentationCapturesStatusBarAppearance = YES;
        }
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSInteger count = self.navigationController.viewControllers.count;
    self.navigationController.interactivePopGestureRecognizer.enabled = count > 1;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    if ([self respondsToSelector:@selector(Jxb_InitalUI)]) {
        [self Jxb_InitalUI];
    }
    if ([self respondsToSelector:@selector(Jxb_SetLayouts)]) {
        [self Jxb_SetLayouts];
    }
    if ([self respondsToSelector:@selector(Jxb_BeginKvo)]) {
        [self Jxb_BeginKvo];
    }
    if ([self respondsToSelector:@selector(Jxb_Loaddata)]) {
        [self Jxb_Loaddata];
    }
}

#pragma mark - gesture delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count == 1)//关闭主界面的右滑返回
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark -actionCustomLeftBtnWithNrlImage
- (void)actionCustomLeftBtnWithNrlImage:(NSString *)nrlImage htlImage:(NSString *)hltImage
                                  title:(NSString *)title
                                 action:(void(^)())btnClickBlock {
    self.navLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.navLeftBtn setBackgroundColor:[UIColor clearColor]];
    objc_setAssociatedObject(self.navLeftBtn, &btnClickAction, btnClickBlock, OBJC_ASSOCIATION_COPY);
    [self actionCustomNavBtn:self.navLeftBtn nrlImage:nrlImage htlImage:hltImage title:title];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
}

#pragma mark -actionCustomRightBtnWithNrlImage
- (void)actionCustomRightBtnWithNrlImage:(NSString *)nrlImage htlImage:(NSString *)hltImage
                                   title:(NSString *)title
                                  action:(void(^)())btnClickBlock {
    self.navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    objc_setAssociatedObject(self.navRightBtn, &btnClickAction, btnClickBlock, OBJC_ASSOCIATION_COPY);
    [self actionCustomNavBtn:self.navRightBtn nrlImage:nrlImage htlImage:hltImage title:title];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn];
}

#pragma mark -actionCustomNavBtn
- (void)actionCustomNavBtn:(UIButton *)btn nrlImage:(NSString *)nrlImage
                  htlImage:(NSString *)hltImage
                     title:(NSString *)title {
    [btn setImage:[UIImage imageNamed:nrlImage] forState:UIControlStateNormal];
    if (hltImage) {
        [btn setImage:[UIImage imageNamed:hltImage] forState:UIControlStateHighlighted];
    } else {
        [btn setImage:[UIImage imageNamed:nrlImage] forState:UIControlStateNormal];
    }
    if (title) {
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16.];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    }
    [btn sizeToFit];
    [btn addTarget:self action:@selector(actionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -actionBtnClick
- (void)actionBtnClick:(UIButton *)btn {
    void (^btnClickBlock) (void) = objc_getAssociatedObject(btn, &btnClickAction);
    btnClickBlock();
}

#pragma mark -getter or setter
- (void)setItemTitle:(NSString *)title {
    _itemTitle = title;
    [self.navigationItem setTitle:_itemTitle];
}

- (void)setShowBackBtn:(BOOL)showBack {
    __weak typeof(self) wSelf = self;
    [self actionCustomLeftBtnWithNrlImage:@"btn_back" htlImage:nil title:nil action:^{
        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
}

@end
