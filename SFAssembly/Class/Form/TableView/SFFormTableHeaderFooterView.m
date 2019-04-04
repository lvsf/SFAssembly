//
//  SFFormTableHeaderFooterView.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/13.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormTableHeaderFooterView.h"
#import "SFAssemblyView.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface SFFormTableHeaderFooterView()
@property (nonatomic,strong) SFAssemblyView *assemblyView;
@end

@implementation SFFormTableHeaderFooterView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.form_headerFooter.delegate respondsToSelector:@selector(formSectionHeaderFooterDidSelected:)]) {
        [self.form_headerFooter.delegate formSectionHeaderFooterDidSelected:self.form_headerFooter];
    }
}

- (CGSize)sizeThatFits:(CGSize)size {
    [self.form_headerFooter.layout.container setWidth:size.width];
    [self.form_headerFooter.layout.container setHeight:size.height?:CGFLOAT_MAX];
    [self.form_headerFooter.layout sizeToFit];
    return self.form_headerFooter.layout.size;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.assemblyView setFrame:self.contentView.bounds];
}

- (void)headerFooterViewDidLoad:(SFFormTableSection *)section headerFooter:(SFFormSectionHeaderFooter *)headerFooter {
    [self.backgroundView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.assemblyView];
}

- (void)headerFooterViewWillAppear:(SFFormTableSection *)section headerFooter:(SFFormSectionHeaderFooter *)headerFooter {
    if (self.fd_isTemplateLayoutHeaderFooterView) {
        [self.assemblyView setLayoutForHeightCalculate:headerFooter.layout];
    }
    else {
        [self.assemblyView setLayout:headerFooter.layout];
        [self setNeedsLayout];
    }
}

- (SFAssemblyView *)assemblyView {
    return _assemblyView?:({
        _assemblyView = [SFAssemblyView new];
        _assemblyView;
    });
}

@end
