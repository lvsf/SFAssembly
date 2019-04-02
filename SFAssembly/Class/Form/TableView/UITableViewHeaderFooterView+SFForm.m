//
//  UITableViewHeaderFooterView+SFForm.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/13.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "UITableViewHeaderFooterView+SFForm.h"
#import <objc/runtime.h>

@implementation UITableViewHeaderFooterView (SFForm)

- (void)setForm_headerFooter:(SFFormSectionHeaderFooter *)form_headerFooter {
    objc_setAssociatedObject(self, @selector(form_headerFooter), form_headerFooter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setForm_isLoad:(BOOL)form_isLoad {
    objc_setAssociatedObject(self, @selector(form_isLoad), @(form_isLoad), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)form_isLoad {
    return objc_getAssociatedObject(self, _cmd)?[objc_getAssociatedObject(self, _cmd) boolValue]:NO;
}

- (SFFormSectionHeaderFooter *)form_headerFooter {
    return objc_getAssociatedObject(self, _cmd);
}

@end
