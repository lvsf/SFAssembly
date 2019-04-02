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
@end

@implementation SFFormTableHeaderFooterView

- (void)headerFooterViewDidLoad:(SFFormTableSection *)section headerFooter:(SFFormSectionHeaderFooter *)headerFooter {
    [self setBackgroundView:[UIView new]];
    [self.contentView addSubview:self.assemblyView];
}

- (void)headerFooterViewWillAppear:(SFFormTableSection *)section headerFooter:(SFFormSectionHeaderFooter *)headerFooter {
    [self.assemblyView setLayout:headerFooter];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.form_headerFooter.delegate respondsToSelector:@selector(formSectionHeaderFooterDidSelected:)]) {
        [self.form_headerFooter.delegate formSectionHeaderFooterDidSelected:self.form_headerFooter];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.assemblyView setFrame:self.bounds];
}

- (SFAssemblyView *)assemblyView {
    return _assemblyView?:({
        _assemblyView = [SFAssemblyView new];
        _assemblyView;
    });
}

@end
