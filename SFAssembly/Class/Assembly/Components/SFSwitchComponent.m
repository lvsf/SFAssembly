//
//  SFSwitchComponent.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/5.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFSwitchComponent.h"
#import "NSObject+SFEvent.h"

@implementation SFSwitchComponent

- (instancetype)init {
    if (self = [super init]) {
        [self addActionForControlEvents:UIControlEventValueChanged actionBlock:^(SFSwitchComponent *actionObject, UISwitch *sender, id userInfo) {
            [actionObject setOn:sender.on];
        }];
    }
    return self;
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    [self setOn:on];
    [(UISwitch *)self.view setOn:on animated:animated];
}

+ (UIView *)componentView {
    return [UISwitch new];
}

- (BOOL)componentViewShouldDisplay {
    return YES;
}

- (void)componentViewWillAppear:(UISwitch *)view {
    [super componentViewWillAppear:view];
    [view setOn:self.on];
}

- (CGSize)componentViewBoundSizeThatFits:(CGSize)size {
    return [self.view sizeThatFits:size];
}

@end
