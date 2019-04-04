//
//  SFButtonComponent.m
//  SFAssembly
//
//  Created by YunSL on 2019/1/24.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFButtonComponent.h"

@implementation SFButtonComponentStatus
@end

@implementation SFButtonComponent

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
    BOOL (^valid)(SFButtonComponentStatus *) = ^BOOL(SFButtonComponentStatus *status){
        return (status.title.length > 0 || status.attributedTitle.length > 0 || status.image);
    };
    return (valid(self.normalStatus) ||
            valid(self.disableStatus) ||
            valid(self.highlightedStatus) ||
            valid(self.selectedStatus));
}

- (void)componentViewWillAppear:(UIButton *)view {
    [super componentViewWillAppear:view];
    [self p_updateWithButton:view status:_normalStatus state:UIControlStateNormal];
    [self p_updateWithButton:view status:_highlightedStatus state:UIControlStateHighlighted];
    [self p_updateWithButton:view status:_selectedStatus state:UIControlStateSelected];
    [self p_updateWithButton:view status:_disableStatus state:UIControlStateDisabled];
    [view.titleLabel setFont:self.font];
    [view.titleLabel setNumberOfLines:0];
    [view.titleLabel setTextAlignment:self.textAlignment];
    [view.titleLabel setLineBreakMode:self.lineBreakMode];
    [view setTitleEdgeInsets:self.titleEdgeInsets];
    [view setImageEdgeInsets:self.imageEdgeInsets];
}

- (CGSize)componentViewBoundSizeThatFits:(CGSize)size {
    NSLog(@"button componentViewBoundSizeThatFits");
    return [[(UIButton *)self.view titleLabel] sizeThatFits:size];
}

- (void)p_updateWithButton:(UIButton *)button status:(SFButtonComponentStatus *)componentStatus state:(UIControlState)state {
    [button setTitleColor:componentStatus.titleColor forState:state];
    [button setImage:componentStatus.image forState:state];
    [button setBackgroundImage:componentStatus.backgroundImage forState:state];
    [button setTitle:componentStatus.title forState:state];
    [button setAttributedTitle:componentStatus.attributedTitle forState:state];
}

- (SFButtonComponentStatus *)highlightedStatus {
    return _highlightedStatus?:({
        _highlightedStatus = [SFButtonComponentStatus new];
        _highlightedStatus;
    });
}

- (SFButtonComponentStatus *)normalStatus {
    return _normalStatus?:({
        _normalStatus = [SFButtonComponentStatus new];
        _normalStatus;
    });
}

- (SFButtonComponentStatus *)selectedStatus {
    return _selectedStatus?:({
        _selectedStatus = [SFButtonComponentStatus new];
        _selectedStatus;
    });
}

- (SFButtonComponentStatus *)disableStatus {
    return _disableStatus?:({
        _disableStatus = [SFButtonComponentStatus new];
        _disableStatus;
    });
}

@end
