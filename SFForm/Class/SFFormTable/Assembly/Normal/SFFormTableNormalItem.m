//
//  SFFormTableNormalItem.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormTableNormalItem.h"
#import "SFFormAssemblyNormalLayout.h"

@implementation SFFormTableNormalItem
@synthesize headerComponent = _headerComponent;
@synthesize subHeaderComponent = _subHeaderComponent;
@synthesize contentComponent = _contentComponent;
@synthesize subFooterComponent = _subFooterComponent;
@synthesize footerComponent = _footerComponent;
@synthesize supportSpacing = _supportSpacing;
@synthesize contentSpacing = _contentSpacing;

- (instancetype)init {
    if (self = [super init]) {
        self.contentSpacing = 15;
        self.supportSpacing = 15;
        self.containerInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    }
    return self;
}

+ (instancetype)labelItemWithIcon:(UIImage *)image title:(NSString *)title content:(NSString *)content selected:(SFFormEventBlock)selectedBlock {
    SFFormTableNormalItem *item = [SFFormTableNormalItem new];
    item.iconImageView.image = image;
    item.titleLabel.text = title;
    item.contentLabel.text = content;
    [item addProtocolEvent:@selector(tableView:didSelectRowAtIndexPath:)
                     block:selectedBlock];
    return item;
}

- (NSArray<SFFormViewComponent *> *)allComponents {
    NSMutableArray *components = [[super allComponents] mutableCopy];
    if (_headerComponent) {
        [components addObject:_headerComponent];
    }
    if (_subHeaderComponent) {
        [components addObject:_subHeaderComponent];
    }
    if (_contentComponent) {
        [components addObject:_contentComponent];
    }
    if (_subFooterComponent) {
        [components addObject:_subFooterComponent];
    }
    if (_footerComponent) {
        [components addObject:_footerComponent];
    }
    return components.copy;
}

- (SFFormImageViewComponent *)iconImageView {
    SFFormImageViewComponent *iconImageView = (id<SFFormComponentProtocol>)_headerComponent;
    if (iconImageView == nil) {
        iconImageView = _iconImageView?:({
            _iconImageView = [SFFormImageViewComponent new];
            _iconImageView;
        });
        _headerComponent = iconImageView;
    }
    return iconImageView;
}

- (SFFormLabelComponent *)titleLabel {
    SFFormLabelComponent *titleLabel = (id<SFFormComponentProtocol>)_subHeaderComponent;
    if (titleLabel == nil) {
        titleLabel = _titleLabel?:({
            _titleLabel = [SFFormLabelComponent new];
            _titleLabel;
        });
        _subHeaderComponent = titleLabel;
    }
    return titleLabel;
}

- (SFFormLabelComponent *)detailLabel {
    SFFormLabelComponent *detailLabel = (id<SFFormComponentProtocol>)_footerComponent;
    if (detailLabel == nil) {
        detailLabel = _detailLabel?:({
            _detailLabel = [SFFormLabelComponent new];
            _detailLabel;
        });
        _footerComponent = detailLabel;
    }
    return detailLabel;
}

- (SFFormLabelComponent *)contentLabel {
    SFFormLabelComponent *contentLabel = (id<SFFormComponentProtocol>)_contentComponent;
    if (contentLabel == nil) {
        contentLabel = _contentLabel?:({
            _contentLabel = [SFFormLabelComponent new];
            _contentLabel;
        });
        _contentComponent = contentLabel;
    }
    return contentLabel;
}

- (SFFormYYLabelComponent *)contentYYLabel {
    SFFormYYLabelComponent *contentYYLabel = (id<SFFormComponentProtocol>)_contentComponent;
    if (contentYYLabel == nil) {
        contentYYLabel = _contentYYLabel?:({
            _contentYYLabel = [SFFormYYLabelComponent new];
            _contentYYLabel;
        });
        _contentComponent = contentYYLabel;
    }
    return contentYYLabel;
}

- (SFFormImageViewComponent *)contentImageView {
    SFFormImageViewComponent *contentImageView = (id<SFFormComponentProtocol>)_contentComponent;
    if (contentImageView == nil) {
        contentImageView = _contentImageView?:({
            _contentImageView = [SFFormImageViewComponent new];
            _contentImageView;
        });
        _contentComponent = contentImageView;
    }
    return contentImageView;
}

- (SFFormTextFieldComponent *)contentTextField {
    SFFormTextFieldComponent *contentTextField = (id<SFFormComponentProtocol>)_contentComponent;
    if (contentTextField == nil) {
        contentTextField = _contentTextField?:({
            _contentTextField = [SFFormTextFieldComponent new];
            _contentTextField;
        });
        _contentComponent = contentTextField;
    }
    return contentTextField;
}

- (SFFormButtonComponent *)contentButton {
    SFFormButtonComponent *contentButton = (id<SFFormComponentProtocol>)_contentComponent;
    if (contentButton == nil) {
        contentButton = _contentButton?:({
            _contentButton = [SFFormButtonComponent new];
            _contentButton;
        });
        _contentComponent = contentButton;
    }
    return contentButton;
}

- (id<SFFormAssemblyLayoutProtocol>)layout {
    return _layout?:({
        _layout = [SFFormAssemblyNormalLayout new];
        _layout;
    });
}

@end
