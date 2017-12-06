//
//  UITableView+SFAdd.h
//  SFFormView
//
//  Created by YunSL on 17/10/20.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (SFAdd)

@property (nonatomic,assign,readonly) NSInteger sf_numberOfSections;
@property (nonatomic,assign,readonly) NSInteger sf_numberOfRows;

/**
 注册cell默认的重用标志格式

 @param block 注册block
 */
+ (void)sf_registCellReuseIdentifierWithBlock:(NSString *(^)(NSString *className))block;

/**
 注册cell
 
 @param className       cell类名
 @param reuseIdentifier cell重用标志
 */
- (void)sf_registerCellWithClassName:(NSString *)className
                     reuseIdentifier:(NSString *)reuseIdentifier;

/**
 注册UITableViewHeaderFooterView

 @param className       UITableViewHeaderFooterView类名
 @param reuseIdentifier UITableViewHeaderFooterView重用标志
 */
- (void)sf_registerHeaderFooterViewWithClassName:(NSString *)className
                                 reuseIdentifier:(NSString *)reuseIdentifier;

/**
 获取cell重用标志

 @param className cell类名
 @return reuseIdentifier
 */
- (NSString *)sf_cellReuseIdentifierWithClassName:(NSString *)className;

/**
 获取可用cell

 @param className       cell类名
 @param reuseIdentifier cell重用标志
 @param indexpath       cell位置索引
 @return cell
 */
- (UITableViewCell *)sf_cellWithClassName:(NSString *)className
                          reuseIdentifier:(NSString *)reuseIdentifier
                                indexPath:(NSIndexPath *)indexpath;

/**
 添加一个自tableHeaderView视图到tableView底部的背景试图

 @param color -
 */
- (void)sf_addBodyBackgroudViewWithColor:(UIColor *)color;

/**
 设置tableFooterView
 
 @param footer        -
 @param width         宽度,为0根据contentInset计算
 @param height        高度,不能为0
 @param contentInsets 内边距
 */
- (void)sf_setTableFooterView:(UIView *)footer
                        width:(CGFloat)width
                       height:(CGFloat)height
                contentInsets:(UIEdgeInsets)contentInsets;

- (void)sf_setTableHeaderView:(UIView *)header
                        width:(CGFloat)width
                       height:(CGFloat)height;
@end
