//
//  SFFormSectionHeaderFooter.m
//  QuanYou
//
//  Created by YunSL on 2018/1/24.
//  Copyright © 2018年 YunSL. All rights reserved.
//

#import "SFFormSectionHeaderFooter.h"
#import "SFFormSectionHeaderFooterLayoutDataSource.h"

@implementation SFFormSectionHeaderFooter
@synthesize sectionLayout = _sectionLayout;

- (BOOL)shouldLoadHeaderFooter {
    return (self.layout.places.count > 0 || self.view || self.layout.container.height > 0);
}

- (SFAssemblyLayout *)layout {
    return _layout?:self.sectionLayout;
}

- (SFFormSectionHeaderFooterLayout *)sectionLayout {
    return _sectionLayout?:({
        _sectionLayout = [SFFormSectionHeaderFooterLayout new];
        _sectionLayout.dataSource = [SFFormSectionHeaderFooterLayoutDataSource new];
        _sectionLayout;
    });
}

@end
