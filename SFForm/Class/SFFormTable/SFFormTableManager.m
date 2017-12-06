//
//  SFFormTableManager.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormTableManager.h"
#import "NSObject+SFAddForm.h"
#import "UITableView+SFAdd.h"
#import "UITableView+SFAddForm.h"
#import "UITableViewCell+SFAddForm.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "UITableViewHeaderFooterView+SFAddForm.h"

@implementation SFFormTableManager

+ (Class)formManagerSectionClass {
    return [SFFormTableSection class];
}

+ (Class)formManagerItemClass {
    return [SFFormTableItem class];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableView.sf_manager.sections.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [(SFFormTableSection *)[tableView.sf_manager sectionAtIndex:section] header].height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [(SFFormTableSection *)[tableView.sf_manager sectionAtIndex:section] footer].height;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SFFormTableSection *tableSection = (SFFormTableSection*)[tableView.sf_manager sectionAtIndex:section];
    return [self viewForTableSection:tableSection headerFooter:tableSection.header];
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    SFFormTableSection *tableSection = (SFFormTableSection*)[tableView.sf_manager sectionAtIndex:section];
    return [self viewForTableSection:tableSection headerFooter:tableSection.footer];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableView.sf_manager sectionAtIndex:section].items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SFFormTableItem *item = (SFFormTableItem*)[tableView.sf_manager itemAtIndexPath:indexPath];
    
    NSString *reuseIdentifier = item.reuseIdentifier?:[tableView sf_cellReuseIdentifierWithClassName:item.className];
    [tableView sf_registerCellWithClassName:item.className reuseIdentifier:reuseIdentifier];

    CGFloat height = item.expectHeight;
    if (height <= 0 || item.enforceFrameLayout) {
        if (item.cacheHeight) {
            height = [tableView fd_heightForCellWithIdentifier:reuseIdentifier cacheByKey:[@([item hash]) stringValue] configuration:^(id cell) {
                [cell setFd_enforceFrameLayout:item.enforceFrameLayout];
                [cell setSf_item:item];
                [cell sf_reload];
            }];
        }
        else {
            height = [tableView fd_heightForCellWithIdentifier:reuseIdentifier configuration:^(id cell) {
                [cell setFd_enforceFrameLayout:item.enforceFrameLayout];
                [cell setSf_item:item];
                [cell sf_reload];
            }];
        }
    }
    return height;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SFFormTableItem *item = (SFFormTableItem*)[tableView.sf_manager itemAtIndexPath:indexPath];
    item.indexPath = indexPath;

    NSString *reuseIdentifier = item.reuseIdentifier?:[tableView sf_cellReuseIdentifierWithClassName:item.className];
    [tableView sf_registerCellWithClassName:item.className reuseIdentifier:reuseIdentifier];
 
    UITableViewCell *cell = [tableView sf_cellWithClassName:item.className
                                            reuseIdentifier:reuseIdentifier
                                                  indexPath:indexPath];
    cell.sf_item = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    SFFormTableItem *item = (SFFormTableItem*)[tableView.sf_manager itemAtIndexPath:indexPath];
    item.indexPath = indexPath;
    if (cell.sf_isLoad == NO) {
        cell.sf_isLoad = YES;
        if ([cell respondsToSelector:@selector(cellDidLoad:)]) {
            [cell performSelector:@selector(cellDidLoad:)
                       withObject:item];
        }
    }
    if ([cell respondsToSelector:@selector(cellWillAppear:)]) {
        [cell performSelector:@selector(cellWillAppear:)
                   withObject:item];
    }
    [self tableView:tableView excuteEvent:_cmd indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self tableView:tableView excuteEvent:_cmd indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView excuteEvent:(SEL)event indexPath:(NSIndexPath *)indexPath {
    SFFormTableItem *item = (SFFormTableItem*)[tableView.sf_manager itemAtIndexPath:indexPath];
    [tableView.sf_manager excuteProtocolEvent:event
                                       sender:[tableView cellForRowAtIndexPath:indexPath]
                                     userInfo:item];
    [item excuteProtocolEvent:event
                       sender:[tableView cellForRowAtIndexPath:indexPath]
                     userInfo:item];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexTitles;
}

#pragma mark - pravite
- (UITableViewHeaderFooterView*)viewForTableSection:(SFFormTableSection *)section headerFooter:(SFFormSectionHeaderFooter *)sectionHeaderFooter {
    if (sectionHeaderFooter.shouldLoadHeaderFooter) {
        NSString *className = sectionHeaderFooter.className;
        NSString *reuseIdentifier = sectionHeaderFooter.reuseIdentifier?:[self.tableView sf_cellReuseIdentifierWithClassName:className];
        [self.tableView sf_registerHeaderFooterViewWithClassName:className
                                                 reuseIdentifier:reuseIdentifier];
        UITableViewHeaderFooterView *headerFooterView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
        if (headerFooterView.sf_isLoad == NO) {
            headerFooterView.sf_isLoad = YES;
            if ([headerFooterView respondsToSelector:@selector(headerFooterViewDidLoad:headerFooter:)]) {
                [headerFooterView performSelector:@selector(headerFooterViewDidLoad:headerFooter:)
                                       withObject:section
                                       withObject:sectionHeaderFooter];
            }
        }
        if ([headerFooterView respondsToSelector:@selector(headerFooterViewWillAppear:headerFooter:)]) {
            [headerFooterView performSelector:@selector(headerFooterViewWillAppear:headerFooter:)
                                   withObject:section
                                   withObject:sectionHeaderFooter];
        }
        return headerFooterView;
    }
    return nil;
}

@end
