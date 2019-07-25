//
//  SFFormTableItem.h
//  SFFormView
//
//  Created by YunSL on 17/10/19.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFFormItem.h"

@protocol SFTableItemDelegate <NSObject>
@end

@interface SFTableItem : SFFormItem
/**
 是否缓存高度,默认为YES
 */
@property (nonatomic,assign) BOOL cacheHeight;

@property (nonatomic,assign) BOOL hiddenSeparator;
@property (nonatomic,assign) UIEdgeInsets separatorInset;
@property (nonatomic,assign) CGFloat rowHeight;
@property (nonatomic,assign) CGFloat minHeight;
@property (nonatomic,assign) CGFloat maxHeight;
@property (nonatomic) UITableViewCellSelectionStyle selectionStyle;
@property (nonatomic) UITableViewCellAccessoryType accessoryType;
@property (nonatomic,assign,readonly) CGFloat height;

@property (nonatomic,weak) id<SFTableItemDelegate> delegate;

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) UITableViewCell *cell;

- (void)reloadData;

@end
