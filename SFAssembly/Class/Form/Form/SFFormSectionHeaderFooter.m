//
//  SFFormSectionHeaderFooter.m
//  QuanYou
//
//  Created by YunSL on 2018/1/24.
//  Copyright © 2018年 YunSL. All rights reserved.
//

#import "SFFormSectionHeaderFooter.h"

@implementation SFFormSectionHeaderFooter
@synthesize sectionLayout = _sectionLayout;

- (instancetype)init {
    if (self = [super init]) {
        _cacheHeight = NO;
    }
    return self;
}

- (BOOL)shouldLoadHeaderFooter {
    return (self.layout.places.count > 0 || self.layout.container.height > 0);
}

- (SFAssemblyLayout *)layout {
    return _layout?:self.sectionLayout;
}

- (SFFormSectionHeaderFooterLayout *)sectionLayout {
    return _sectionLayout?:({
        _sectionLayout = [SFFormSectionHeaderFooterLayout new];
        _sectionLayout;
    });
}

@end
