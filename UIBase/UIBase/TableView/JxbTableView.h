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
 *  Header或者Footer的模型
 */
@interface JxbTableHeadorFootModel : NSObject
@property (nonatomic, assign)           CGFloat                  height;
@property (nonatomic, copy, nullable)   JxbTableHeadorFootBlock  block;
@end

/**
 *  Section的模型
 */
@interface JxbTableViewSectionModel : NSObject
@property (nonatomic, strong, nonnull ) NSMutableArray           *arrCells;
@property (nonatomic, strong, nullable) JxbTableHeadorFootModel  *header;
@property (nonatomic, strong, nullable) JxbTableHeadorFootModel  *footer;
@end

/**
 *  Cell的模型
 */
@interface JxbTableViewCellModel : NSObject
@property (nonatomic, copy  , nonnull)  JxbTableCellBlock         BlockCell;
@property (nonatomic, assign)           CGFloat                   height;
@end

@interface JxbTableView : UITableView

/**
 *  tableview的datasource
 */
@property (nonatomic, strong, nonnull) NSMutableArray             *arraySections;

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
