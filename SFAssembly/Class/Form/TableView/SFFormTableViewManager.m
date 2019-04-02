//
//  SFFormTableViewManager.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/1.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFFormTableViewManager.h"
#import "UITableView+SFForm.h"
#import "UITableViewCell+SFForm.h"
#import "UITableViewHeaderFooterView+SFForm.h"
#import "UITableView+FDTemplateLayoutCell.h"

@implementation SFFormTableViewManager

+ (instancetype)managerWithTableView:(UITableView *)tableView {
    SFFormTableViewManager *manager = [SFFormTableViewManager new];
    manager.tableView = tableView;
    return manager;
}

+ (SFFormConfiguration *)configuration  {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SFFormConfiguration new];
    });
    return instance;
}

+ (Class)formManagerSectionClass {
    return [SFFormTableSection class];
}

+ (Class)formManagerItemClass {
    return [SFFormTableItem class];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableView.form_manager.sections.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [(SFFormTableSection *)[tableView.form_manager sectionAtIndex:section] header].size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [(SFFormTableSection *)[tableView.form_manager sectionAtIndex:section] footer].size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SFFormTableSection *tableViewSection = (SFFormTableSection *)[tableView.form_manager sectionAtIndex:section];
    return [self _viewForTableSection:tableViewSection headerFooter:tableViewSection.header];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    SFFormTableSection *tableViewSection = (SFFormTableSection *)[tableView.form_manager sectionAtIndex:section];
    return [self _viewForTableSection:tableViewSection headerFooter:tableViewSection.footer];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SFFormTableSection *tableViewSection = (SFFormTableSection *)[tableView.form_manager sectionAtIndex:section];
    tableViewSection.sectionIndex = section;
    return tableViewSection.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SFFormTableItem *item = (SFFormTableItem *)[tableView.form_manager itemAtIndexPath:indexPath];
    NSString *reuseIdentifier = item.reuseIdentifier?:[SFFormTableViewManager configuration].reuseIdentifierForClassName(item.className);
    [tableView form_registerCellWithClassName:item.className reuseIdentifier:reuseIdentifier];
    CGFloat height = item.rowHeight;
    if (height <= 0) {
        if (item.cacheHeight) {
            NSString *cacheKey = [NSString stringWithFormat:@"%p_%@",item,NSStringFromCGSize(tableView.bounds.size)];
            height = [tableView fd_heightForCellWithIdentifier:reuseIdentifier cacheByKey:cacheKey configuration:^(id cell) {
                [cell setFd_enforceFrameLayout:item.enforceFrameLayout];
                [cell setForm_item:item];
                [cell form_reload];
            }];
        }
        else {
            height = [tableView fd_heightForCellWithIdentifier:reuseIdentifier configuration:^(id cell) {
                [cell setFd_enforceFrameLayout:item.enforceFrameLayout];
                [cell setForm_item:item];
                [cell form_reload];
            }];
        }
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SFFormTableItem *item = (SFFormTableItem *)[tableView.form_manager itemAtIndexPath:indexPath];
    item.indexPath = indexPath;
    NSString *reuseIdentifier = item.reuseIdentifier?:[SFFormTableViewManager configuration].reuseIdentifierForClassName(item.className);
    [tableView form_registerCellWithClassName:item.className reuseIdentifier:reuseIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    SFFormTableItem *item = (SFFormTableItem *)[tableView.form_manager itemAtIndexPath:indexPath];
    [item setIndexPath:indexPath];
    [item setCell:cell];
    [cell setForm_item:item];
    [cell form_reload];
    if (item.rowHeight > 0 && item.enforceFrameLayout) {
        [cell sizeThatFits:CGSizeMake(CGRectGetWidth(tableView.bounds), item.rowHeight)];
    }
    [self tableView:tableView excuteEvent:_cmd indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self tableView:tableView excuteEvent:_cmd indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView excuteEvent:(SEL)event indexPath:(NSIndexPath *)indexPath {
    SFFormTableItem *item = (SFFormTableItem *)[tableView.form_manager itemAtIndexPath:indexPath];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexTitles;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {}

#pragma mark - pravite
- (UITableViewHeaderFooterView *)_viewForTableSection:(SFFormTableSection *)section headerFooter:(SFFormSectionHeaderFooter *)sectionHeaderFooter {
    if (sectionHeaderFooter.shouldLoadHeaderFooter) {
        NSString *className = sectionHeaderFooter.className;
        NSString *reuseIdentifier = sectionHeaderFooter.reuseIdentifier?:[SFFormTableViewManager configuration].reuseIdentifierForClassName(className);
        [self.tableView form_registerHeaderFooterViewWithClassName:className reuseIdentifier:reuseIdentifier];
        UITableViewHeaderFooterView *headerFooterView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
        [headerFooterView setForm_headerFooter:sectionHeaderFooter];
        if (headerFooterView.form_isLoad == NO) {
            headerFooterView.form_isLoad = YES;
            if ([headerFooterView respondsToSelector:@selector(headerFooterViewDidLoad:headerFooter:)]) {
                [(id<SFTableViewHeaderFooterViewProtocol>)headerFooterView headerFooterViewDidLoad:section
                                                                                      headerFooter:sectionHeaderFooter];
            }
        }
        if ([headerFooterView respondsToSelector:@selector(headerFooterViewWillAppear:headerFooter:)]) {
            [(id<SFTableViewHeaderFooterViewProtocol>)headerFooterView headerFooterViewWillAppear:section
                                                                                     headerFooter:sectionHeaderFooter];
        }
        return headerFooterView;
    }
    return nil;
}

@end
