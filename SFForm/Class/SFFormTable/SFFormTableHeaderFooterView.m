//
//  SFFormTableHeaderFooterView.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/13.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormTableHeaderFooterView.h"
#import "YYText.h"
#import "Masonry.h"

@interface SFFormTableHeaderFooterView()
@property (nonatomic,strong) YYLabel *label;
@end

@implementation SFFormTableHeaderFooterView

- (void)headerFooterViewDidLoad:(SFFormTableSection *)section headerFooter:(SFFormSectionHeaderFooter *)headerFooter {
    [self setBackgroundView:[UIView new]];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.label];
    [headerFooter.sectionLabel componentViewDidLoad:self.label];
}

- (void)headerFooterViewWillAppear:(SFFormTableSection *)section headerFooter:(SFFormSectionHeaderFooter *)headerFooter {
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(headerFooter.contentInsets.left);
        make.right.equalTo(self.contentView).offset(-headerFooter.contentInsets.right);
        make.top.equalTo(self.contentView).offset(headerFooter.contentInsets.top);
        make.bottom.equalTo(self.contentView).offset(-headerFooter.contentInsets.bottom);
    }];
    [self.contentView setBackgroundColor:headerFooter.backgroundColor];
    [headerFooter.sectionLabel componentViewWillAppear:self.label];
}

- (YYLabel *)label {
    return _label?:({
        _label = [[YYLabel alloc] initWithFrame:self.contentView.bounds];
        _label.backgroundColor = [UIColor clearColor];
        _label;
    });
}

@end
