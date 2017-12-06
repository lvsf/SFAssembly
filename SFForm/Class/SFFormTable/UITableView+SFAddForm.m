//
//  UITableView+SFAddForm.m
//  SFFormView
//
//  Created by YunSL on 17/10/19.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "UITableView+SFAddForm.h"
#import "UITableView+SFAdd.h"
#import "UITableViewCell+SFAddForm.h"
#import "SFMultipleDelegate.h"
#import <objc/runtime.h>

static inline void SFSwizzleInstanceMethod(Class cls, SEL originalSel, SEL newSel) {
    Method originalMethod = class_getInstanceMethod(cls, originalSel);
    Method newMethod = class_getInstanceMethod(cls, newSel);
    class_addMethod(cls,
                    originalSel,
                    class_getMethodImplementation(cls, originalSel),
                    method_getTypeEncoding(originalMethod));
    class_addMethod(cls,
                    newSel,
                    class_getMethodImplementation(cls, newSel),
                    method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(cls, originalSel),
                                   class_getInstanceMethod(cls, newSel));
};

@implementation UITableView (SFAddForm)

+ (void)load {
    SFSwizzleInstanceMethod(self, @selector(setDelegate:), @selector(sf_setDelegate:));
    SFSwizzleInstanceMethod(self, @selector(setDataSource:), @selector(sf_setDataSource:));
}

- (void)sf_setDelegate:(id<UITableViewDelegate>)delegate {
    if (self.sf_enable) {
        [self.sf_multipleDelegate setOriginalDelegate:delegate];
    }
    else {
        [self sf_setDelegate:delegate];
    }
}

- (void)sf_setDataSource:(id<UITableViewDataSource>)dataSource {
    if (self.sf_enable) {
        [self.sf_multipleDataSource setOriginalDelegate:dataSource];
    }
    else {
        [self sf_setDataSource:dataSource];
    }
}

- (void)setSf_enable:(BOOL)sf_enable {
    if (sf_enable && !self.sf_enable) {
        //1.delegate
        [self.sf_multipleDelegate addDelegate:self.sf_manager];
        [self.sf_multipleDelegate setOriginalDelegate:self.delegate];
        [self sf_setDelegate:(id<UITableViewDelegate>)self.sf_multipleDelegate];
        //2.dataSource
        [self.sf_multipleDataSource addDelegate:self.sf_manager];
        [self.sf_multipleDataSource setOriginalDelegate:self.dataSource];
        [self sf_setDataSource:(id<UITableViewDataSource>)self.sf_multipleDataSource];
    }
    if (!sf_enable && self.sf_enable) {
        //1.delegate
        [self sf_setDelegate:self.sf_multipleDelegate.originalDelegate];
        [self.sf_multipleDelegate setOriginalDelegate:nil];
        [self.sf_multipleDelegate removeDelegate:self.sf_manager];
        //2.dataSource
        [self sf_setDataSource:self.sf_multipleDataSource.originalDelegate];
        [self.sf_multipleDataSource setOriginalDelegate:nil];
        [self.sf_multipleDataSource removeDelegate:self.sf_manager];
    }
    objc_setAssociatedObject(self, @selector(sf_enable), @(sf_enable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSf_manager:(SFFormTableManager *)sf_manager {
    objc_setAssociatedObject(self, @selector(sf_manager), sf_manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)sf_enable {
    return objc_getAssociatedObject(self, _cmd)?[objc_getAssociatedObject(self, _cmd) boolValue]:NO;
}

- (SFFormTableManager *)sf_manager {
    return objc_getAssociatedObject(self, _cmd)?:({
        SFFormTableManager *manager = [SFFormTableManager new];
        objc_setAssociatedObject(self, _cmd, manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        manager.tableView = self;
        manager;
    });
}

- (SFMultipleDelegate *)sf_multipleDelegate {
    return objc_getAssociatedObject(self, _cmd)?:({
        SFMultipleDelegate *manager = [SFMultipleDelegate new];
        objc_setAssociatedObject(self, _cmd, manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        manager;
    });
}

- (SFMultipleDelegate *)sf_multipleDataSource {
    return objc_getAssociatedObject(self, _cmd)?:({
        SFMultipleDelegate *manager = [SFMultipleDelegate new];
        objc_setAssociatedObject(self, _cmd, manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        manager;
    });
}

@end
