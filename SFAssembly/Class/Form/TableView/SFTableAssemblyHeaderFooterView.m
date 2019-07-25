//
//  SFTableAssemblyHeaderFooterView.m
//  SFAssembly
//
//  Created by YunSL on 2017/11/13.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFTableAssemblyHeaderFooterView.h"
#import "SFAssemblyView.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface SFTableAssemblyHeaderFooterView()
@property (nonatomic,strong,readonly) SFTableAssemblySectionHeaderFooter *assemblySectionHeaderFooter;
@property (nonatomic,strong) SFAssemblyView *assemblyView;
@property (nonatomic,strong) SFAssemblyLayoutManager *assemblyLayoutManager;
@end

@implementation SFTableAssemblyHeaderFooterView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.form_headerFooter.delegate respondsToSelector:@selector(formSectionHeaderFooterDidSelected:)]) {
        [self.form_headerFooter.delegate formSectionHeaderFooterDidSelected:self.assemblySectionHeaderFooter];
    }
}

- (CGSize)sizeThatFits:(CGSize)size {
    [self.assemblyLayoutManager setLayout:self.assemblySectionHeaderFooter.layout];
    return [self.assemblyLayoutManager sizeThatFits:CGSizeMake(size.width, size.height?:CGFLOAT_MAX)];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.assemblyView setFrame:self.contentView.bounds];
}

- (void)headerFooterViewDidLoad:(SFTableSection *)section headerFooter:(SFTableAssemblySectionHeaderFooter *)headerFooter {
    if (!self.fd_isTemplateLayoutHeaderFooterView) {
        [self setBackgroundView:[UIView new]];
        [self.contentView addSubview:self.assemblyView];
    }
}

- (void)headerFooterViewWillAppear:(SFTableSection *)section headerFooter:(SFTableAssemblySectionHeaderFooter *)headerFooter {
    if (!self.fd_isTemplateLayoutHeaderFooterView) {
        [self.assemblyView setLayout:headerFooter.layout];
        [self.assemblyView udpate];
        [self.assemblyView setBackgroundColor:headerFooter.backgroundColor];
    }
}

- (SFTableAssemblySectionHeaderFooter *)assemblySectionHeaderFooter {
    return (SFTableAssemblySectionHeaderFooter *)self.form_headerFooter;
}

- (SFAssemblyView *)assemblyView {
    return _assemblyView?:({
        _assemblyView = [SFAssemblyView new];
        _assemblyView.layoutManager = self.assemblyLayoutManager;
        _assemblyView;
    });
}

- (SFAssemblyLayoutManager *)assemblyLayoutManager {
    return _assemblyLayoutManager?:({
        _assemblyLayoutManager = [SFAssemblyLayoutManager new];
        _assemblyLayoutManager;
    });
}

@end
