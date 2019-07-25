//
//  SFTableAssemblyItem.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/2.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFTableAssemblyItem.h"

@implementation SFTableAssemblyItem
@synthesize formLayout = _formLayout;

- (instancetype)init {
    if (self = [super init]) {
        self.className = @"SFTableAssemblyCell";
    }
    return self;
}

- (void)setFormLayout:(SFAssemblyEasyFormLayout *)formLayout {
    _formLayout = formLayout;
    _layout = formLayout;
}

- (SFAssemblyEasyFormLayout *)formLayout {
    if (_layout && ![_layout isEqual:_formLayout]) {
        return nil;
    }
    return _formLayout?:({
        _formLayout = [SFAssemblyEasyFormLayout new];
        _layout = _formLayout;
        _formLayout;
    });
}

@end
