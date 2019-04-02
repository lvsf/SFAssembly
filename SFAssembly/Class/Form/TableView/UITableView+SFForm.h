//
//  UITableView+SFForm.h
//  SFAssembly
//
//  Created by YunSL on 2019/4/1.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFFormTableViewManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (SFForm)
@property (nonatomic,assign) BOOL form_enable;
@property (nonatomic,strong) SFFormTableViewManager *form_manager;

/**
 注册cell
 
 @param className       cell类名
 @param reuseIdentifier cell重用标志
 */
- (void)form_registerCellWithClassName:(NSString *)className
                       reuseIdentifier:(NSString *)reuseIdentifier;

/**
 注册UITableViewHeaderFooterView
 
 @param className       UITableViewHeaderFooterView类名
 @param reuseIdentifier UITableViewHeaderFooterView重用标志
 */
- (void)form_registerHeaderFooterViewWithClassName:(NSString *)className
                                   reuseIdentifier:(NSString *)reuseIdentifier;

@end
NS_ASSUME_NONNULL_END
