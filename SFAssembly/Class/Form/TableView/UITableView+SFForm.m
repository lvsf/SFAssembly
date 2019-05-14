//
//  UITableView+SFForm.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/1.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "UITableView+SFForm.h"
#import "SFMultipleProxy.h"
#import <objc/runtime.h>

@implementation UITableView (SFForm)

+ (void)load {
    void(^SFFormSwizzleInstanceMethod)(SEL originalSel, SEL newSel) = ^(SEL originalSel, SEL newSel){
        Method originalMethod = class_getInstanceMethod(self, originalSel);
        Method newMethod = class_getInstanceMethod(self, newSel);
        class_addMethod(self,
                        originalSel,
                        class_getMethodImplementation(self, originalSel),
                        method_getTypeEncoding(originalMethod));
        class_addMethod(self,
                        newSel,
                        class_getMethodImplementation(self, newSel),
                        method_getTypeEncoding(newMethod));
        
        method_exchangeImplementations(class_getInstanceMethod(self, originalSel),
                                       class_getInstanceMethod(self, newSel));
    };
    SFFormSwizzleInstanceMethod(@selector(setDelegate:),@selector(form_setDelegate:));
    SFFormSwizzleInstanceMethod(@selector(setDataSource:),@selector(form_setDataSource:));
}

- (void)form_setDelegate:(id<UITableViewDelegate>)delegate {
    [self form_setDelegate:delegate];
    if (self.form_enable) {
        [self multipleDelegate].originalProxy = delegate;
        if ([self.delegate isEqual:[self multipleDelegate]] == NO) {
            [self form_setDelegate:[self multipleDelegate]];
        }
    }
}

- (void)form_setDataSource:(id<UITableViewDataSource>)dataSource {
    [self form_setDataSource:dataSource];
    if (self.form_enable) {
        [self multipleDataSource].originalProxy = dataSource;
        if ([self.dataSource isEqual:[self multipleDataSource]] == NO) {
            [self form_setDataSource:[self multipleDataSource]];
        }
    }
}

- (void)form_registerCellWithClassName:(NSString *)className reuseIdentifier:(NSString *)reuseIdentifier {
    NSAssert((className.length > 0 && NSClassFromString(className)), ([NSString stringWithFormat:@"[SFForm] can't find class with name '%@'",className]));
    NSMutableDictionary *registerCells = objc_getAssociatedObject(self, _cmd);
    if (registerCells == nil) {
        registerCells = [NSMutableDictionary new];
        objc_setAssociatedObject(self, _cmd, registerCells, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    NSString *key = [NSString stringWithFormat:@"%@_%@",className,reuseIdentifier];
    if (registerCells[key] == nil) {
        registerCells[key] = @(YES);
        if (([[NSBundle mainBundle] pathForResource:className ofType:@"nib"])) {
            [self registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:reuseIdentifier];
        }
        else {
            [self registerClass:NSClassFromString(className) forCellReuseIdentifier:reuseIdentifier];
        }
    }
}

- (void)form_registerHeaderFooterViewWithClassName:(NSString *)className reuseIdentifier:(NSString *)reuseIdentifier {
    NSAssert((className.length > 0 && NSClassFromString(className)), ([NSString stringWithFormat:@"[SFForm] can't find class with name '%@'",className]));
    NSMutableDictionary *registerHeaderFooterViews = objc_getAssociatedObject(self, _cmd);
    if (registerHeaderFooterViews == nil) {
        registerHeaderFooterViews = [NSMutableDictionary new];
        objc_setAssociatedObject(self, _cmd, registerHeaderFooterViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    NSString *key = [NSString stringWithFormat:@"%@_%@",className,reuseIdentifier];
    if (registerHeaderFooterViews[key] == nil) {
        registerHeaderFooterViews[key] = @(YES);
        if (([[NSBundle mainBundle] pathForResource:className ofType:@"nib"])) {
            [self registerNib:[UINib nibWithNibName:className bundle:nil] forHeaderFooterViewReuseIdentifier:reuseIdentifier];
        }
        else {
            [self registerClass:NSClassFromString(className) forHeaderFooterViewReuseIdentifier:reuseIdentifier];
        }
    }
}

- (void)setForm_enable:(BOOL)form_enable {
    objc_setAssociatedObject(self, @selector(form_enable), @(form_enable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (form_enable) {
        if ([self.delegate isEqual:[self multipleDelegate]] == NO) {
            [self multipleDelegate].originalProxy = self.delegate;
            [self form_setDelegate:[self multipleDelegate]];
        }
        if ([self.dataSource isEqual:[self multipleDataSource]] == NO) {
            [self multipleDataSource].originalProxy = self.dataSource;
            [self form_setDataSource:[self multipleDataSource]];
        }
    }
    else {
        if ([self.delegate isEqual:[self multipleDelegate]]) {
            [self form_setDelegate:[self multipleDelegate].originalProxy];
        }
        if ([self.dataSource isEqual:[self multipleDataSource]]) {
            [self form_setDataSource:[self multipleDataSource].originalProxy];
        }
    }
}

- (void)setForm_manager:(SFTableViewManager *)form_manager {
    objc_setAssociatedObject(self, @selector(form_manager), form_manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)form_enable {
    return objc_getAssociatedObject(self, @selector(form_enable))?[objc_getAssociatedObject(self, @selector(form_enable)) boolValue]:NO;
}

- (SFTableViewManager *)form_manager {
    return objc_getAssociatedObject(self, @selector(form_manager))?:({
        SFTableViewManager *manager = [SFTableViewManager managerWithTableView:self];
        objc_setAssociatedObject(self, @selector(form_manager), manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        manager;
    });
}

- (SFMultipleProxy *)multipleDelegate {
    return objc_getAssociatedObject(self, _cmd)?:({
        SFMultipleProxy *proxy = [SFMultipleProxy new];
        [proxy addProxy:self.form_manager];
        objc_setAssociatedObject(self, _cmd, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        proxy;
    });
}

- (SFMultipleProxy *)multipleDataSource {
    return objc_getAssociatedObject(self, _cmd)?:({
        SFMultipleProxy *proxy = [SFMultipleProxy new];
        [proxy addProxy:self.form_manager];
        objc_setAssociatedObject(self, _cmd, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        proxy;
    });
}

@end
