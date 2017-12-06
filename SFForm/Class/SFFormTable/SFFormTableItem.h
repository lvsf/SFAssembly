//
//  SFFormTableItem.h
//  SFFormView
//
//  Created by YunSL on 17/10/19.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFFormItem.h"

@interface SFFormTableItem : SFFormItem
@property (nonatomic,assign) BOOL enforceFrameLayout;
@property (nonatomic) BOOL cacheHeight;
@property (nonatomic) UITableViewCellSelectionStyle selectionStyle;
@property (nonatomic) UITableViewCellAccessoryType accessoryType;
@property (nonatomic,assign) CGFloat expectHeight;
@property (nonatomic,assign,readonly) CGFloat height;
@end
