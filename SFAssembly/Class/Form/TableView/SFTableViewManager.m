//
//  SFTableViewManager.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/1.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFTableViewManager.h"
#import "NSObject+SFEvent.h"
#import "UITableView+SFForm.h"
#import "UITableViewCell+SFForm.h"
#import "UITableViewHeaderFooterView+SFForm.h"
#import "UITableView+FDTemplateLayoutCell.h"

@implementation SFTableViewManager

+ (instancetype)managerWithTableView:(UITableView *)tableView {
    SFTableViewManager *manager = [SFTableViewManager new];
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
    return [SFTableSection class];
}

+ (Class)formManagerItemClass {
    return [SFTableItem class];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableView.form_manager.sections.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    SFTableSection *tableViewSection = (SFTableSection *)[tableView.form_manager sectionAtIndex:section];
    SFTableSectionHeaderFooter *header = [tableViewSection sectionHeader];
    if ([header shouldLoadHeaderFooter]) {
        NSString *reuseIdentifier = header.reuseIdentifier?:[SFTableViewManager configuration].reuseIdentifierForClassName(header.className);
        NSString *cacheKey = header.cacheHeight?[NSString stringWithFormat:@"%p_%@",header,@(CGRectGetWidth(tableView.bounds))]:nil;
        [tableView form_registerHeaderFooterViewWithClassName:header.className reuseIdentifier:reuseIdentifier];
        return [tableView fd_heightForHeaderFooterViewWithIdentifier:reuseIdentifier cacheByKey:cacheKey configuration:^(id headerFooterView) {
            [headerFooterView setForm_headerFooter:header];
            [headerFooterView form_reloadForSection:tableViewSection];
        }];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    SFTableSection *tableViewSection = (SFTableSection *)[tableView.form_manager sectionAtIndex:section];
    SFFormSectionHeaderFooter *footer = [tableViewSection sectionFooter];
    if ([footer shouldLoadHeaderFooter]) {
        NSString *reuseIdentifier = footer.reuseIdentifier?:[SFTableViewManager configuration].reuseIdentifierForClassName(footer.className);
        NSString *cacheKey = footer.cacheHeight?[NSString stringWithFormat:@"%p_%@",footer,@(CGRectGetWidth(tableView.bounds))]:nil;
        [tableView form_registerHeaderFooterViewWithClassName:footer.className reuseIdentifier:reuseIdentifier];
        return [tableView fd_heightForHeaderFooterViewWithIdentifier:reuseIdentifier cacheByKey:cacheKey configuration:^(id headerFooterView) {
            [headerFooterView setForm_headerFooter:footer];
            [headerFooterView form_reloadForSection:tableViewSection];
        }];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SFTableSection *tableViewSection = (SFTableSection *)[tableView.form_manager sectionAtIndex:section];
    SFFormSectionHeaderFooter *header = [tableViewSection sectionHeader];
    if ([header shouldLoadHeaderFooter]) {
        return [self _viewForTableSection:tableViewSection headerFooter:header];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    SFTableSection *tableViewSection = (SFTableSection *)[tableView.form_manager sectionAtIndex:section];
    SFFormSectionHeaderFooter *footer = [tableViewSection sectionFooter];
    if ([footer shouldLoadHeaderFooter]) {
        return [self _viewForTableSection:tableViewSection headerFooter:footer];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SFTableSection *tableViewSection = (SFTableSection *)[tableView.form_manager sectionAtIndex:section];
    tableViewSection.sectionIndex = section;
    return tableViewSection.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (CGSizeEqualToSize(tableView.bounds.size, CGSizeZero)) {
        return 0;
    }
    SFTableItem *item = (SFTableItem *)[tableView.form_manager itemAtIndexPath:indexPath];
    item.tableView = tableView;
    NSString *reuseIdentifier = item.reuseIdentifier?:[SFTableViewManager configuration].reuseIdentifierForClassName(item.className);
    [tableView form_registerCellWithClassName:item.className reuseIdentifier:reuseIdentifier];
    CGFloat height = item.rowHeight;
    if (height <= 0) {
        if (item.cacheHeight) {
            NSString *cacheKey = [NSString stringWithFormat:@"%p_%@",item,@(CGRectGetWidth(tableView.bounds))];
            height = [tableView fd_heightForCellWithIdentifier:reuseIdentifier cacheByKey:cacheKey configuration:^(id cell) {
                [cell setForm_item:item];
                [cell form_reload];
            }];
        }
        else {
            height = [tableView fd_heightForCellWithIdentifier:reuseIdentifier configuration:^(id cell) {
                [cell setForm_item:item];
                [cell form_reload];
            }];
        }
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SFTableItem *item = (SFTableItem *)[tableView.form_manager itemAtIndexPath:indexPath];
    item.indexPath = indexPath;
    NSString *reuseIdentifier = item.reuseIdentifier?:[SFTableViewManager configuration].reuseIdentifierForClassName(item.className);
    [tableView form_registerCellWithClassName:item.className reuseIdentifier:reuseIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    SFTableItem *item = (SFTableItem *)[tableView.form_manager itemAtIndexPath:indexPath];
    [item setIndexPath:indexPath];
    [item setCell:cell];
    [cell setForm_item:item];
    [cell form_reload];    
    [self _triggerActionForSelector:_cmd withTableViewCell:cell indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self _triggerActionForSelector:_cmd withTableViewCell:[tableView cellForRowAtIndexPath:indexPath] indexPath:indexPath];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexTitles;
}

#pragma mark - pravite
- (void)_triggerActionForSelector:(SEL)selector withTableViewCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    if (cell) {
        userInfo[@"UITableViewCell"] = cell;
    }
    if (indexPath) {
        userInfo[@"NSIndexPath"] = indexPath;
    }
    SFTableItem *item = (SFTableItem *)[self.tableView.form_manager itemAtIndexPath:indexPath];
    [item sendActionsForSelectorEvent:selector sender:self.tableView userInfo:userInfo];
    [self sendActionsForSelectorEvent:selector sender:self.tableView userInfo:userInfo];
}

- (UITableViewHeaderFooterView *)_viewForTableSection:(SFTableSection *)section headerFooter:(SFFormSectionHeaderFooter *)sectionHeaderFooter {
    NSString *className = sectionHeaderFooter.className;
    NSString *reuseIdentifier = sectionHeaderFooter.reuseIdentifier?:[SFTableViewManager configuration].reuseIdentifierForClassName(className);
    [self.tableView form_registerHeaderFooterViewWithClassName:className reuseIdentifier:reuseIdentifier];
    UITableViewHeaderFooterView *headerFooterView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    [headerFooterView setForm_headerFooter:sectionHeaderFooter];
    [headerFooterView form_reloadForSection:section];
    return headerFooterView;
}

@end
