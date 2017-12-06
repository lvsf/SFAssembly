//
//  UITableViewHeaderFooterView+SFAddForm.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/13.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "UITableViewHeaderFooterView+SFAddForm.h"
#import <objc/runtime.h>

@implementation UITableViewHeaderFooterView (SFAddForm)

- (void)setSf_isLoad:(BOOL)sf_isLoad {
    objc_setAssociatedObject(self, @selector(sf_isLoad), @(sf_isLoad), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)sf_isLoad {
    return objc_getAssociatedObject(self, _cmd)?[objc_getAssociatedObject(self, _cmd) boolValue]:NO;
}

@end
