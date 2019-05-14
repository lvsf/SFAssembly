//
//  UITableViewCell+SFForm.m
//  SFFormView
//
//  Created by YunSL on 17/10/20.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "UITableViewCell+SFForm.h"
#import <objc/runtime.h>

@implementation UITableViewCell (SFForm)

#pragma mark - public
- (void)form_reload {
    if (self.form_isLoad == NO) {
        self.form_isLoad = YES;
        if ([self respondsToSelector:@selector(cellDidLoad:)]) {
            [(id<SFFormTableViewCellProtocol>)self cellDidLoad:self.form_item];
        }
    }
    [self _update];
    if ([self respondsToSelector:@selector(cellWillAppear:)]) {
        [(id<SFFormTableViewCellProtocol>)self cellWillAppear:self.form_item];
    }
}

#pragma mark - pravite
- (void)_update {
    self.accessoryType = self.form_item.accessoryType;
    self.selectionStyle = self.form_item.selectionStyle;
    self.contentView.backgroundColor = self.form_item.backgroundColor;
    if (self.form_item.hiddenSeparator) {
        self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth([UIScreen mainScreen].bounds), 0, 0);
    }
    else {
        self.separatorInset = self.form_item.separatorInset;
    }
}

#pragma mark - set/get
- (void)setForm_item:(SFTableItem *)form_item {
    objc_setAssociatedObject(self, @selector(form_item), form_item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setForm_isLoad:(BOOL)form_isLoad {
    objc_setAssociatedObject(self, @selector(form_isLoad), @(form_isLoad), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SFTableItem *)form_item {
    return objc_getAssociatedObject(self, _cmd);
}

- (BOOL)form_isLoad {
    return objc_getAssociatedObject(self, _cmd)?[objc_getAssociatedObject(self, _cmd) boolValue]:NO;
}

@end
