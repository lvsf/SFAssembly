//
//  SFControlComponent.m
//  SFAssembly
//
//  Created by YunSL on 2019/1/24.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFControlComponent.h"

@implementation SFControlComponent

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
    [view setHighlighted:self.highlighted];
    [view setContentHorizontalAlignment:self.contentHorizontalAlignment];
    [view setContentVerticalAlignment:self.contentVerticalAlignment];
}

@end
