//
//  SFFormButtonComponent.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/12.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormButtonComponent.h"

@implementation SFFormButtonComponentStatus
@end

@implementation SFFormButtonComponent

- (instancetype)init {
    if (self = [super init]) {
        self.font = [UIFont systemFontOfSize:15];
        self.lineBreakMode = NSLineBreakByWordWrapping;
        self.textAlignment = NSTextAlignmentLeft;
        self.titleEdgeInsets = UIEdgeInsetsZero;
        self.imageEdgeInsets = UIEdgeInsetsZero;
        self.contentInsets = UIEdgeInsetsZero;
        self.numberOfLines = 0;
    }
    return self;
}

+ (UIView *)componentView {
    return [UIButton buttonWithType:UIButtonTypeCustom];
}

- (BOOL)componentViewShouldDisplay {
    BOOL (^valid)(SFFormButtonComponentStatus *) = ^BOOL(SFFormButtonComponentStatus *status){
        return (status.title.length > 0 || status.attributedTitle.length > 0 || status.image);
    };
    return (valid(self.normalStatus) ||
            valid(self.disableStatus) ||
            valid(self.highlightedStatus) ||
            valid(self.selectedStatus));
}

- (CGSize)componentView:(UIButton *)view boundSizeThatFits:(CGSize)size {
    if (self.layoutMode == SFFormComponentLayouModeFill) {
        return size;
    }
    return [view sizeThatFits:size];
}

- (void)componentViewWillAppear:(UIButton *)view {
    [super componentViewWillAppear:view];
    [self handleUpdateWithButton:view status:_normalStatus state:UIControlStateNormal];
    [self handleUpdateWithButton:view status:_highlightedStatus state:UIControlStateHighlighted];
    [self handleUpdateWithButton:view status:_selectedStatus state:UIControlStateSelected];
    [self handleUpdateWithButton:view status:_disableStatus state:UIControlStateDisabled];
    [view.titleLabel setFont:self.font];
    [view.titleLabel setNumberOfLines:0];
    [view.titleLabel setTextAlignment:self.textAlignment];
    [view.titleLabel setLineBreakMode:self.lineBreakMode];
    [view setTitleEdgeInsets:self.titleEdgeInsets];
    [view setImageEdgeInsets:self.imageEdgeInsets];
}

- (void)handleUpdateWithButton:(UIButton*)button status:(SFFormButtonComponentStatus*)componentStatus state:(UIControlState)state {
    if (componentStatus) {
        [button setTitleColor:componentStatus.titleColor forState:state];
        [button setTitleShadowColor:componentStatus.shadowColor forState:state];
        [button setImage:componentStatus.image forState:state];
        [button setBackgroundImage:componentStatus.backgroundImage forState:state];
        [button setAttributedTitle:componentStatus.attributedTitle forState:state];
        [button setTitle:componentStatus.title forState:state];
    }
}

- (SFFormButtonComponentStatus *)highlightedStatus {
    return _highlightedStatus?:({
        _highlightedStatus = [SFFormButtonComponentStatus new];
        _highlightedStatus;
    });
}

- (SFFormButtonComponentStatus *)normalStatus {
    return _normalStatus?:({
        _normalStatus = [SFFormButtonComponentStatus new];
        _normalStatus;
    });
}

- (SFFormButtonComponentStatus *)selectedStatus {
    return _selectedStatus?:({
        _selectedStatus = [SFFormButtonComponentStatus new];
        _selectedStatus;
    });
}

- (SFFormButtonComponentStatus *)disableStatus {
    return _disableStatus?:({
        _disableStatus = [SFFormButtonComponentStatus new];
        _disableStatus;
    });
}

@end
