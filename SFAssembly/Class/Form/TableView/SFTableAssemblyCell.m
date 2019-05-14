//
//  SFTableAssemblyCell.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/1.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFTableAssemblyCell.h"
#import "SFAssemblyView.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface SFTableAssemblyCell()
@property (nonatomic,strong,readonly) SFTableAssemblyItem *assemblyItem;
@property (nonatomic,strong) SFAssemblyView *assemblyView;
@property (nonatomic,strong) SFAssemblyLayoutManager *assemblyLayoutManager;
@end

@implementation SFTableAssemblyCell


- (instancetype)init {
    if (self = [super init]) {
        self.fd_enforceFrameLayout = YES;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
}

- (CGSize)sizeThatFits:(CGSize)size {
    [self.assemblyLayoutManager setLayout:self.assemblyItem.layout];
    return [self.assemblyLayoutManager sizeThatFits:CGSizeMake(size.width, size.height?:CGFLOAT_MAX)];
}

- (void)cellDidLoad:(SFTableAssemblyItem *)item {
    if (!self.fd_isTemplateLayoutCell) {
        [self.contentView addSubview:self.assemblyView];
    }
}

- (void)cellWillAppear:(SFTableAssemblyItem *)item {
    if (!self.fd_isTemplateLayoutCell) {
        [self.assemblyView setLayout:item.layout];
        [self.assemblyView udpate];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.assemblyView setFrame:self.contentView.bounds];
}

- (SFTableAssemblyItem *)assemblyItem {
    return (SFTableAssemblyItem *)self.form_item;
}

- (SFAssemblyLayoutManager *)assemblyLayoutManager {
    return _assemblyLayoutManager?:({
        _assemblyLayoutManager = [SFAssemblyLayoutManager new];
        _assemblyLayoutManager;
    });
}

- (SFAssemblyView *)assemblyView {
    return _assemblyView?:({
        _assemblyView = [SFAssemblyView new];
        _assemblyView.layoutManager = self.assemblyLayoutManager;
        _assemblyView;
    });
}

@end
