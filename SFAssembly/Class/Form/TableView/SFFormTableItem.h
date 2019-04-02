//
//  SFFormTableItem.h
//  SFFormView
//
//  Created by YunSL on 17/10/19.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFFormItem.h"

@interface SFFormTableItem : SFFormItem
/**
 是否缓存高度,默认为YES
 */
@property (nonatomic,assign) BOOL cacheHeight;

/**
 是否开启强制布局,默认为NO,此时由rowHeight或者cell的自适应来确定高度,为YES时则调用cell的sizeThatFits:来确定cell高度
 */
@property (nonatomic,assign) BOOL enforceFrameLayout;
@property (nonatomic,assign) BOOL hiddenSeparator;
@property (nonatomic,assign) UIEdgeInsets separatorInset;
@property (nonatomic,assign) CGFloat rowHeight;
@property (nonatomic,assign) CGFloat minHeight;
@property (nonatomic,assign) CGFloat maxHeight;
@property (nonatomic) UITableViewCellSelectionStyle selectionStyle;
@property (nonatomic) UITableViewCellAccessoryType accessoryType;
@property (nonatomic,assign,readonly) CGFloat height;

@property (nonatomic,weak) UITableViewCell *cell;

@end
