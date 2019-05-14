//
//  SFFormTableSection.m
//  SFFormView
//
//  Created by YunSL on 17/10/19.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFTableSection.h"

@implementation SFTableSection
@synthesize header = _header;
@synthesize footer = _footer;
@synthesize assemblyHeader = _assemblyHeader;
@synthesize assemblyFooter = _assemblyFooter;

- (SFTableSectionHeaderFooter *)sectionHeader {
    return _assemblyHeader?:_header;
}

- (SFTableSectionHeaderFooter *)sectionFooter {
    return _assemblyFooter?:_footer;
}

- (SFTableSectionHeaderFooter *)header {
    return _header?:({
        _header = [SFTableSectionHeaderFooter new];
        _header.kind = SFFormSectionKindHeader;
        _header;
    });
}

- (SFTableSectionHeaderFooter *)footer {
    return _footer?:({
        _footer = [SFTableSectionHeaderFooter new];
        _footer.kind = SFFormSectionKindFooter;
        _footer;
    });
}

- (SFTableAssemblySectionHeaderFooter *)assemblyHeader {
    return _assemblyHeader?:({
        _assemblyHeader = [SFTableAssemblySectionHeaderFooter new];
        _assemblyHeader.kind = SFFormSectionKindHeader;
        _assemblyHeader;
    });
}

- (SFTableAssemblySectionHeaderFooter *)assemblyFooter {
    return _assemblyFooter?:({
        _assemblyFooter = [SFTableAssemblySectionHeaderFooter new];
        _assemblyFooter.kind = SFFormSectionKindFooter;
        _assemblyFooter;
    });
}

@end
