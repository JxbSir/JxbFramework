//
//  JxbTableView.h
//  UIBase
//
//  Created by Peter on 16/7/28.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  设置Header或者Footer的block
 *
 *  @param section   section索引
 *  @param tableView tableView
 *
 *  @return UIView
 */
typedef UIView * _Nullable           (^JxbTableHeadorFootBlock)(NSInteger section, UITableView * _Nonnull tableView);

/**
 *  设置Cell的block
 *
 *  @param indexPath indexPath索引
 *  @param tableView tableView
 *
 *  @return UITableViewCell
 */
typedef UITableViewCell * _Nonnull   (^JxbTableCellBlock)(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableView);

/**
 *  设置Cell点击block
 *
 *  @param indexPath indexPath索引
 *  @param tableView tableView
 */
typedef void (^JxbTableCellActionBlock)(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableView);

/**
 *  Header或者Footer的模型
 */
@interface JxbTableHeadFootModel : NSObject
@property (nonatomic, assign)           CGFloat                  height;
@property (nonatomic, copy, nullable)   JxbTableHeadorFootBlock  block;

/**
 *  创建模型
 *
 *  @param height header或footer的高度
 *  @param block  返回view的block
 *
 *  @return       实例
 */
+ (instancetype _Nonnull)createModel:(CGFloat)height viewForBlock:(JxbTableHeadorFootBlock _Nullable)block;
@end

/**
 *  Section的模型
 */
@interface JxbTableViewSectionModel : NSObject
@property (nonatomic, strong, nonnull ) NSMutableArray           *arrCells;
@property (nonatomic, strong, nullable) JxbTableHeadFootModel    *header;
@property (nonatomic, strong, nullable) JxbTableHeadFootModel    *footer;

/**
 *  创建模型
 *
 *  @param arrCelss    JxbTableViewCellModel模型的数组
 *  @param headerModel JxbTableHeadorFootModel模型，设置section的header
 *  @param footerModel JxbTableHeadorFootModel模型，设置section的footer
 *
 *  @return            实例
 */
+ (instancetype _Nonnull)createModel:(NSMutableArray* _Nonnull)arrCelss headerModel:(JxbTableHeadFootModel* _Nullable)headerModel footerModel:(JxbTableHeadFootModel* _Nullable)footerModel;
@end

/**
 *  Cell的模型
 */
@interface JxbTableViewCellModel : NSObject
@property (nonatomic, copy  , nonnull)  JxbTableCellBlock         BlockCell;
@property (nonatomic, copy  , nonnull)  JxbTableCellActionBlock   BlockAction;
@property (nonatomic, assign)           CGFloat                   height;

/**
 *  创建模型
 *
 *  @param heigth         表格cell的高度
 *  @param viewForBlock   设置cell样式的block，返回UITableViewCell类型
 *  @param actionForBlock 设置cell的点击事件
 *
 *  @return               实例
 */
+ (instancetype _Nonnull)createModel:(CGFloat)heigth viewForBlock:(JxbTableCellBlock _Nonnull)viewForBlock actionForBlock:(JxbTableCellActionBlock _Nullable)actionForBlock;
@end

@interface JxbTableViewEditModel : NSObject
@property (nonatomic, copy  , nonnull)  NSString                 *titleOfEdit;
@property (nonatomic, copy  , nonnull)  JxbTableCellActionBlock  BlockOfEdit;

/**
 *  创建模型
 *
 *  @param titleOfEdit    左滑标题
 *  @param actionForBlock 左滑处理事件
 *
 *  @return               实例
 */
+ (instancetype _Nonnull)createModel:(NSString * _Nonnull)titleOfEdit actionForBlock:(JxbTableCellActionBlock _Nonnull)actionForBlock;

@end

@interface JxbTableView : UITableView

/**
 *  tableview的datasource
 */
@property (nonatomic, strong, nonnull)  NSMutableArray           *arraySections;

/**
 *  可以设置左滑
 */
@property (nonatomic, strong, nullable) JxbTableViewEditModel    *editModel;

/**
 *  构造一个TableView
 *
 *  @return
 */
+ (instancetype _Nonnull)createTableView;

/**
 *  构造一个TableView
 *
 *  @return
 */
+ (instancetype _Nonnull)createTableView:(UITableViewStyle)style;

@end
