//
//  SFFormTableHeaderFooterView.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/13.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormTableHeaderFooterView.h"
#import "SFAssemblyView.h"

@interface SFFormTableHeaderFooterView()
@property (nonatomic,strong) SFAssemblyView *assemblyView;
@property (nonatomic,strong) UIView *displayView;
@end

@implementation SFFormTableHeaderFooterView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.form_headerFooter.delegate respondsToSelector:@selector(formSectionHeaderFooterDidSelected:)]) {
        [self.form_headerFooter.delegate formSectionHeaderFooterDidSelected:self.form_headerFooter];
    }
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize boundSize = size;
    if (self.form_headerFooter.view) {
        if (boundSize.height == 0 || boundSize.height == CGFLOAT_MAX) {
            boundSize.height = CGRectGetHeight(self.form_headerFooter.view.bounds);
        }
    }
    else {
        [self.form_headerFooter.layout.container setWidth:size.width];
        [self.form_headerFooter.layout.container setHeight:size.height?:CGFLOAT_MAX];
        [self.form_headerFooter.layout sizeToFit];
        boundSize = self.form_headerFooter.layout.size;
    }
    return boundSize;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.displayView setFrame:self.contentView.bounds];
}

- (void)headerFooterViewDidLoad:(SFFormTableSection *)section headerFooter:(SFFormSectionHeaderFooter *)headerFooter {
    [self setBackgroundView:[UIView new]];
}

- (void)headerFooterViewWillAppear:(SFFormTableSection *)section headerFooter:(SFFormSectionHeaderFooter *)headerFooter {
    [self.displayView removeFromSuperview];
    if (headerFooter.view) {
        [self setDisplayView:headerFooter.view];
    }
    else {
        [self setDisplayView:self.assemblyView];
        [self.assemblyView setLayout:headerFooter.layout];
    }
    [self.contentView addSubview:self.displayView];
    [self setNeedsLayout];
}

- (SFAssemblyView *)assemblyView {
    return _assemblyView?:({
        _assemblyView = [SFAssemblyView new];
        _assemblyView;
    });
}

@end
