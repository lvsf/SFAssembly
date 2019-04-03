//
//  SFFormSectionHeaderFooterLayout.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/3.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFFormSectionHeaderFooterLayout.h"


@implementation SFFormSectionHeaderFooterLayout
@synthesize topSeparator = _topSeparator;
@synthesize title = _title;
@synthesize detail = _detail;


- (SFAssemblyPlace *)topSeparator {
    return _topSeparator?:({
        _topSeparator = [SFAssemblyPlace new];
        _topSeparator.heightLayoutMode = SFComponentLayoutModeFill;
        [self addPlace:_topSeparator];
        _topSeparator;
    });
}

- (SFAssemblyPlace *)title {
    return _title?:({
        _title = [SFAssemblyPlace new];
        _title.priority = SFAssemblyPlacePriorityHigh;
        [self addPlace:_title];
        _title;
    });
}

- (SFAssemblyPlace *)detail {
    return _detail?:({
        _detail = [SFAssemblyPlace new];
        _detail.priority = SFAssemblyPlacePriorityLow;
        _detail.horizontalPosition = SFComponentPositionFooter;
        [self addPlace:_detail];
        _detail;
    });
}

@end
