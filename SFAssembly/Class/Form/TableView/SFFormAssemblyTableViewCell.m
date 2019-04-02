//
//  SFFormAssemblyTableViewCell.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/1.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFFormAssemblyTableViewCell.h"
#import "SFAssemblyView.h"

@interface SFFormAssemblyTableViewCell()
@property (nonatomic,strong) SFAssemblyView *assemblyView;
@end

@implementation SFFormAssemblyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
}

- (CGSize)sizeThatFits:(CGSize)size {
    [self.assemblyItem.layout.container setWidth:size.width];
    [self.assemblyItem.layout.container setHeight:size.height?:CGFLOAT_MAX];
    [self.assemblyItem.layout sizeToFit];
    return self.assemblyItem.layout.size;
}

- (void)cellDidLoad:(SFFormAssemblyTableItem *)item {
    [self.contentView addSubview:self.assemblyView];
}

- (void)cellWillAppear:(SFFormAssemblyTableItem *)item {
    [self.assemblyView setLayout:item.layout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.assemblyView setFrame:self.contentView.bounds];
}

- (SFFormAssemblyTableItem *)assemblyItem {
    return (SFFormAssemblyTableItem *)self.form_item;
}

- (SFAssemblyView *)assemblyView {
    return _assemblyView?:({
        _assemblyView = [SFAssemblyView new];
        _assemblyView;
    });
}

@end
