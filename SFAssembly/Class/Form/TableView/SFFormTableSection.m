//
//  SFFormTableSection.m
//  SFFormView
//
//  Created by YunSL on 17/10/19.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFFormTableSection.h"

@implementation SFFormTableSection
@synthesize header = _header;
@synthesize footer = _footer;

- (SFFormTableSectionHeaderFooter *)header {
    return _header?:({
        _header = [SFFormTableSectionHeaderFooter new];
        _header.kind = SFFormSectionKindHeader;
        _header;
    });
}

- (SFFormTableSectionHeaderFooter *)footer {
    return _footer?:({
        _footer = [SFFormTableSectionHeaderFooter new];
        _footer.kind = SFFormSectionKindFooter;
        _footer;
    });
}

@end
