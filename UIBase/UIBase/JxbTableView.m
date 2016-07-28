//
//  JxbTableView.m
//  UIBase
//
//  Created by Peter on 16/7/28.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "JxbTableView.h"

@implementation JxbTableHeadorFootModel
@end

@implementation JxbTableViewSectionModel
@end

@implementation JxbTableViewCellModel
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
    JxbTableHeadorFootModel* header = sectionModel.header;
    if (header && header.height > 0) {
        return header.height;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    JxbTableViewSectionModel* sectionModel = self.arraySections[section];
    JxbTableHeadorFootModel* footer = sectionModel.footer;
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
@end
