//
//  SFFormTableSection.m
//  SFFormView
//
//  Created by YunSL on 17/10/19.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFFormTableSection.h"

@implementation SFFormSectionHeaderFooter
@synthesize sectionLabel = _sectionLabel;

- (instancetype)init {
    if (self = [super init]) {
        self.height = CGFLOAT_MIN;
        self.className = @"SFFormTableHeaderFooterView";
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setTitle:(NSAttributedString *)title {
    _title = title;
    self.sectionLabel.attributedText = title;
}

- (BOOL)shouldLoadHeaderFooter {
    return _title || _height > 0;
}

- (SFFormYYLabelComponent *)sectionLabel {
    return _sectionLabel?:({
        _sectionLabel = [SFFormYYLabelComponent new];
        _sectionLabel;
    });
}

@end

@implementation SFFormTableSection
@synthesize header = _header;
@synthesize footer = _footer;

- (SFFormSectionHeaderFooter *)header {
    return _header?:({
        _header = [SFFormSectionHeaderFooter new];
        _header;
    });
}

- (SFFormSectionHeaderFooter *)footer {
    return _footer?:({
        _footer = [SFFormSectionHeaderFooter new];
        _footer;
    });
}

@end
