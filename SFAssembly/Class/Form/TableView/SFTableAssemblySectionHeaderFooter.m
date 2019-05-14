//
//  SFTableAssemblySectionHeaderFooter.m
//  SFAssembly
//
//  Created by YunSL on 2019/5/13.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFTableAssemblySectionHeaderFooter.h"

@implementation SFTableAssemblySectionHeaderFooter
@synthesize easyLayout = _easyLayout;

- (instancetype)init {
    if (self = [super init]) {
        self.className = @"SFTableAssemblyHeaderFooterView";
    }
    return self;
}

- (BOOL)shouldLoadHeaderFooter {
    return (self.layout.places.count > 0 || self.layout.height > 0);
}

- (SFAssemblyLayout *)layout {
    return _layout?:_easyLayout;
}

- (SFFormSectionHeaderFooterLayout *)easyLayout {
    return _easyLayout?:({
        _easyLayout = [SFFormSectionHeaderFooterLayout new];
        _easyLayout;
    });
}

@end
