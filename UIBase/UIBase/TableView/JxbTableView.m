//
//  JxbTableView.m
//  UIBase
//
//  Created by Peter on 16/7/28.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbTableView.h"

@implementation JxbTableHeadFootModel
+(instancetype)createModel:(CGFloat)height viewForBlock:(JxbTableHeadorFootBlock)block {
    JxbTableHeadFootModel* model = [[JxbTableHeadFootModel alloc] init];
    model.height = height;
    model.block = block;
    return model;
}
@end

@implementation JxbTableViewSectionModel
+(instancetype)createModel:(NSMutableArray *)arrCelss headerModel:(JxbTableHeadFootModel *)headerModel footerModel:(JxbTableHeadFootModel *)footerModel {
    JxbTableViewSectionModel* section = [[JxbTableViewSectionModel alloc] init];
    section.arrCells = arrCelss;
    section.header = headerModel;
    section.footer = footerModel;
    return section;
}
@end

@implementation JxbTableViewEditModel
+ (instancetype)createModel:(NSString *)titleOfEdit actionForBlock:(JxbTableCellActionBlock)actionForBlock {
    JxbTableViewEditModel* edit = [[JxbTableViewEditModel alloc] init];
    edit.titleOfEdit = titleOfEdit;
    edit.BlockOfEdit = actionForBlock;
    return edit;
}
@end

@implementation JxbTableViewCellModel
+ (instancetype _Nonnull)createModel:(CGFloat)heigth viewForBlock:(JxbTableCellBlock _Nonnull)viewForBlock actionForBlock:(JxbTableCellActionBlock _Nullable)actionForBlock {
    JxbTableViewCellModel* cell = [[JxbTableViewCellModel alloc] init];
    cell.height = heigth;
    cell.BlockCell = viewForBlock;
    cell.BlockAction = actionForBlock;
    return cell;
}
@end

@interface JxbTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JxbTableView

+ (instancetype)createTableView {
    return [self createTableView:UITableViewStyleGrouped];
}

+ (instancetype)createTableView:(UITableViewStyle)style {
    JxbTableView* tableView = [[JxbTableView alloc] initWithFrame:CGRectZero style:style];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = (id<UITableViewDelegate>)tableView;
    tableView.dataSource = (id<UITableViewDataSource>)tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    return tableView;
}

#pragma mark - setter
- (void)setArraySections:(NSMutableArray *)arraySections {
    _arraySections = arraySections;
    [self reloadData];
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arraySections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JxbTableViewSectionModel* sectionModel = self.arraySections[section];
    return sectionModel.arrCells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    JxbTableViewSectionModel* sectionModel = self.arraySections[section];
    JxbTableHeadFootModel* header = sectionModel.header;
    if (header && header.height > 0) {
        return header.height;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    JxbTableViewSectionModel* sectionModel = self.arraySections[section];
    JxbTableHeadFootModel* footer = sectionModel.footer;
    if (footer && footer.height > 0) {
        return footer.height;
    }
    return 0.1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JxbTableViewSectionModel* sectionModel = self.arraySections[indexPath.section];
    JxbTableViewCellModel* cellModel = sectionModel.arrCells[indexPath.row];
    if (cellModel && cellModel.height > 0) {
        return cellModel.height;
    }
    return 48;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JxbTableViewSectionModel* sectionModel = self.arraySections[section];
    if (sectionModel.header && sectionModel.header.block != NULL) {
        return sectionModel.header.block(section, tableView);
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    JxbTableViewSectionModel* sectionModel = self.arraySections[section];
    if (sectionModel.footer && sectionModel.footer.block != NULL) {
        return sectionModel.footer.block(section, tableView);
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JxbTableViewSectionModel* sectionModel = self.arraySections[indexPath.section];
    JxbTableViewCellModel* cellModel = sectionModel.arrCells[indexPath.row];
    UITableViewCell *cell = cellModel.BlockCell(indexPath, tableView);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JxbTableViewSectionModel* sectionModel = self.arraySections[indexPath.section];
    JxbTableViewCellModel* cellModel = sectionModel.arrCells[indexPath.row];
    if (cellModel.BlockAction != NULL) {
        cellModel.BlockAction(indexPath, tableView);
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    JxbTableViewSectionModel* sectionModel = self.arraySections[indexPath.section];
    JxbTableViewCellModel* cellModel = sectionModel.arrCells[indexPath.row];
    if (cellModel.editModel) {
        return YES;
    }
    return NO;
}

- (NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    JxbTableViewSectionModel* sectionModel = self.arraySections[indexPath.section];
    JxbTableViewCellModel* cellModel = sectionModel.arrCells[indexPath.row];
    return cellModel.editModel.titleOfEdit;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    JxbTableViewSectionModel* sectionModel = self.arraySections[indexPath.section];
    JxbTableViewCellModel* cellModel = sectionModel.arrCells[indexPath.row];
    if (cellModel.editModel && cellModel.editModel.BlockOfEdit) {
        cellModel.editModel.BlockOfEdit(indexPath,tableView);
    }
}
@end
