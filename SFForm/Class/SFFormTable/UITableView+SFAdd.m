//
//  UITableView+SFAdd.m
//  SFFormView
//
//  Created by YunSL on 17/10/20.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "UITableView+SFAdd.h"
#import <objc/runtime.h>
#import <Masonry.h>
#import <YYCategories/NSObject+YYAdd.h>

@interface UIApplication(SFAddRegistBlock)
@property (nonatomic,copy) NSString*(^cellReuseIdentifierBlock)(NSString *className);
@end

@implementation UIApplication(SFAddRegistBlock)
- (void)setCellReuseIdentifierBlock:(NSString *(^)(NSString *))cellReuseIdentifierBlock {
    objc_setAssociatedObject(self, @selector(cellReuseIdentifierBlock), cellReuseIdentifierBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *(^)(NSString *))cellReuseIdentifierBlock {
    return objc_getAssociatedObject(self, _cmd);
}

@end

@interface UITableView()
@property (nonatomic,strong,readonly) UIImageView *bodyBackgroundView;
@property (nonatomic,strong,readonly) UIView *footerContainer;
@end

@implementation UITableView (SFAdd)

#pragma mark - life
+ (void)load {
    [self swizzleInstanceMethod:@selector(setContentOffset:)
                           with:@selector(sf_setContentOffset:)];
}

#pragma mark - public
+ (void)sf_registCellReuseIdentifierWithBlock:(NSString *(^)(NSString *))block {
    [UIApplication sharedApplication].cellReuseIdentifierBlock = block;
}

- (void)sf_registerCellWithClassName:(NSString *)className reuseIdentifier:(NSString *)reuseIdentifier {
    NSAssert((className.length > 0 && NSClassFromString(className)), ([NSString stringWithFormat:@"can't find class with name '%@'",className]));
    NSMutableDictionary *registCells = objc_getAssociatedObject(self, _cmd);
    if (registCells == nil) {
        registCells = [NSMutableDictionary new];
        objc_setAssociatedObject(self, _cmd, registCells, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    NSString *identifier = reuseIdentifier?:[self sf_cellReuseIdentifierWithClassName:className];
    NSString *key = [NSString stringWithFormat:@"%@_%@",className,identifier];
    if ([registCells objectForKey:key]) {
        return;
    }
    if (([[NSBundle mainBundle] pathForResource:className ofType:@"nib"])) {
        [self registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:identifier];
    }
    else {
        [self registerClass:NSClassFromString(className) forCellReuseIdentifier:identifier];
    }
    [registCells setObject:@(YES) forKey:key];
}

- (void)sf_registerHeaderFooterViewWithClassName:(NSString *)className reuseIdentifier:(NSString *)reuseIdentifier {
    NSAssert((className.length > 0 && NSClassFromString(className)), ([NSString stringWithFormat:@"can't find class with name '%@'",className]));
    NSMutableDictionary *registerHeaderFooterViews = objc_getAssociatedObject(self, _cmd);
    if (registerHeaderFooterViews == nil) {
        registerHeaderFooterViews = [NSMutableDictionary new];
        objc_setAssociatedObject(self, _cmd, registerHeaderFooterViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    NSString *identifier = reuseIdentifier?:[self sf_cellReuseIdentifierWithClassName:className];
    NSString *key = [NSString stringWithFormat:@"%@_%@",className,identifier];
    if ([registerHeaderFooterViews objectForKey:key]) {
        return;
    }
    if (([[NSBundle mainBundle] pathForResource:className ofType:@"nib"])) {
        [self registerNib:[UINib nibWithNibName:className bundle:nil] forHeaderFooterViewReuseIdentifier:identifier];
    }
    else {
        [self registerClass:NSClassFromString(className) forHeaderFooterViewReuseIdentifier:identifier];
    }
    [registerHeaderFooterViews setObject:@(YES) forKey:key];
}

- (NSString*)sf_cellReuseIdentifierWithClassName:(NSString *)className {
    NSString *reuseIdentifier = className;
    if ([UIApplication sharedApplication].cellReuseIdentifierBlock) {
        reuseIdentifier = [UIApplication sharedApplication].cellReuseIdentifierBlock(className);
    }
    return reuseIdentifier;
}

- (UITableViewCell *)sf_cellWithClassName:(NSString *)className reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexpath {
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:reuseIdentifier?:[self sf_cellReuseIdentifierWithClassName:className]];
    return cell;
}

- (void)sf_setTableHeaderView:(UIView *)header width:(CGFloat)width height:(CGFloat)height {
    [self setTableHeaderView:header];
    if (width <= 0) {
        [header mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.width.equalTo(self);
            make.height.equalTo(@(height));
        }];
    }
    else {
        [header mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.centerX.equalTo(self);
            make.width.equalTo(@(width));
            make.height.equalTo(@(height));
        }];
    }
}

- (void)sf_setTableFooterView:(UIView *)footer width:(CGFloat)width height:(CGFloat)height contentInsets:(UIEdgeInsets)contentInsets {
    CGFloat footerW = width;
    CGFloat footerX = contentInsets.left;
    CGFloat containerW = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat containerH = height + contentInsets.top + contentInsets.bottom;
    if (footerW <= 0) {
        footerW = containerW - contentInsets.left - contentInsets.right;
    }
    else {
        footerX = (containerW - footerW) * 0.5;
    }
    [footer setFrame:CGRectMake(footerX, contentInsets.top, footerW, height)];
    [self.footerContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.footerContainer addSubview:footer];
    [self.footerContainer setFrame:CGRectMake(0, 0, containerW, containerH)];
    [self setTableFooterView:self.footerContainer];
}

- (void)sf_addBodyBackgroudViewWithColor:(UIColor *)color {
    if (self.bodyBackgroundView.superview == nil) {
        [self addSubview:self.bodyBackgroundView];
    }
    [self.bodyBackgroundView setBackgroundColor:color];
    [self updateBodyBackgroundViewFrame];
}

#pragma mark - swizzle
- (void)sf_setContentOffset:(CGPoint)contentOffset {
    [self sf_setContentOffset:contentOffset];
    if (objc_getAssociatedObject(self, @selector(bodyBackgroundView))) {
        [self updateBodyBackgroundViewFrame];
    }
}

#pragma mark - pravite
- (void)updateBodyBackgroundViewFrame {
    CGFloat y = CGRectGetMaxY(self.tableHeaderView.frame);
    CGFloat h = CGRectGetHeight(self.frame) - y + self.contentOffset.y;
    [self.bodyBackgroundView setFrame:CGRectMake(0, y, CGRectGetWidth(self.frame), h)];
    [self sendSubviewToBack:self.bodyBackgroundView];
}

#pragma mark - set/get
- (UIImageView *)bodyBackgroundView {
    return objc_getAssociatedObject(self, _cmd)?:({
        UIImageView *imageView = [UIImageView new];
        objc_setAssociatedObject(self, _cmd, imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        imageView.clipsToBounds = YES;
        imageView.backgroundColor = [UIColor clearColor];
        imageView;
    });
}

- (UIView *)footerContainer {
    return objc_getAssociatedObject(self, _cmd)?:({
        UIView *container = [UIView new];
        objc_setAssociatedObject(self, _cmd, container, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        container.backgroundColor = [UIColor clearColor];
        container;
    });
}

- (NSInteger)sf_numberOfSections {
    return [self numberOfSections];
}

- (NSInteger)sf_numberOfRows {
    NSInteger sections = self.sf_numberOfSections;
    NSInteger rows = 0;
    if (sections > 0) {
        for (NSInteger section = 0; section < sections; section++) {
            rows += [self numberOfRowsInSection:section];
        }
    }
    return rows;
}

@end
