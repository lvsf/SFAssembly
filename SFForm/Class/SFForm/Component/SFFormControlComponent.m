//
//  SFFormControlComponent.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormControlComponent.h"
#import "NSObject+SFAddForm.h"
#import "YYCategories/UIControl+YYAdd.h"

@implementation SFFormControlComponent

- (instancetype)init {
    if (self = [super init]) {
        self.enabled = YES;
        self.selected = NO;
        self.highlighted = NO;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return self;
}

- (void)componentViewWillAppear:(UIControl *)view {
    [super componentViewWillAppear:view];
    [view setEnabled:self.enabled];
    [view setSelected:self.selected];
    [view setHidden:self.highlighted];
    [view setContentHorizontalAlignment:self.contentHorizontalAlignment];
    [view setContentVerticalAlignment:self.contentVerticalAlignment];
    [view removeAllTargets];
    
    __weak SFFormControlComponent *w_self = self;
    [self.controlEvents enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [view addBlockForControlEvents:[obj integerValue] block:^(id  _Nonnull sender) {
            __strong SFFormControlComponent *s_self = w_self;
            [s_self excuteControlEvent:[obj integerValue] sender:sender userInfo:nil];
        }];
    }];
}

@end
