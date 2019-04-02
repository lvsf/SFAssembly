//
//  TableViewCell.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/2.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)cellDidLoad:(SFFormTableItem *)item {
    [self.contentView addSubview:self.contentLabel];
}

- (void)cellWillAppear:(SFFormTableItem *)item {
    [self.contentLabel setAttributedText:item.object];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentLabel setFrame:self.contentView.bounds];
}

- (YYLabel *)contentLabel {
    return _contentLabel?:({
        _contentLabel = [YYLabel new];
        _contentLabel.numberOfLines = 0;
        _contentLabel;
    });
}

@end
