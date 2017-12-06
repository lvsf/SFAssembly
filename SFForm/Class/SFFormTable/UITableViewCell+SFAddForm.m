//
//  UITableViewCell+SFAddForm.m
//  SFFormView
//
//  Created by YunSL on 17/10/20.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "UITableViewCell+SFAddForm.h"
#import <objc/runtime.h>

@implementation UITableViewCell (SFAddForm)

#pragma mark - public
- (void)sf_reload {
    if (self.sf_isLoad == NO) {
        if ([self respondsToSelector:@selector(cellDidLoad:)]) {
            [self performSelector:@selector(cellDidLoad:) withObject:self.sf_item];
        }
        self.sf_isLoad = YES;
    }
    if ([self respondsToSelector:@selector(cellWillAppear:)]) {
        [self performSelector:@selector(cellWillAppear:) withObject:self.sf_item];
    }
}

#pragma mark - pravite
- (void)updateCell {
    self.accessoryType = self.sf_item.accessoryType;
    self.selectionStyle = self.sf_item.selectionStyle;
}

#pragma mark - set/get
- (void)setSf_item:(SFFormTableItem *)sf_item {
    objc_setAssociatedObject(self, @selector(sf_item), sf_item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self updateCell];
}

- (void)setSf_isLoad:(BOOL)sf_isLoad {
    objc_setAssociatedObject(self, @selector(sf_isLoad), @(sf_isLoad), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SFFormTableItem *)sf_item {
    return objc_getAssociatedObject(self, _cmd);
}

- (BOOL)sf_isLoad {
    return objc_getAssociatedObject(self, _cmd)?[objc_getAssociatedObject(self, _cmd) boolValue]:NO;
}

@end
