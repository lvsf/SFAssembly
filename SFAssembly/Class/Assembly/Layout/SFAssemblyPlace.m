//
//  SFAssemblyPlace.m
//  SFAssembly
//
//  Created by YunSL on 2019/1/22.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFAssemblyPlace.h"

@implementation SFAssemblyPlace

- (instancetype)init {
    if (self = [super init]) {
        self.horizontalPosition = SFPlacePositionHeader;
        self.verticalPosition = SFPlacePositionCenter;
        self.widthLayoutMode = SFPlaceLayoutModeFit;
        self.heightLayoutMode = SFPlaceLayoutModeFit;
    }
    return self;
}

- (void)update {
    if (_component.view && [_component respondsToSelector:@selector(componentViewWillAppear:)]) {
        [_component componentViewWillAppear:_component.view];
    }
}

- (CGFloat)componentXWithComponentWidth:(CGFloat)componentWidth contentX:(CGFloat)contentX contentWidth:(CGFloat)contentWidth {
    CGFloat x = 0;
    switch (self.horizontalPosition) {
        case SFPlacePositionHeader:{
            x = contentX;
        }
            break;
        case SFPlacePositionCenter:{
            x = contentX + (contentWidth - componentWidth) * 0.5;
        }
            break;
        case SFPlacePositionFooter:{
            x = contentX + (contentWidth - componentWidth);
        }
            break;
    }
    return x;
}

- (CGFloat)componentYWithComponentHeight:(CGFloat)componentHeight contentY:(CGFloat)contentY contentHeight:(CGFloat)contentHeight {
    CGFloat y = 0;
    switch (self.verticalPosition) {
        case SFPlacePositionHeader:{
            y = contentY;
        }
            break;
        case SFPlacePositionCenter:{
            y = contentY + (contentHeight - componentHeight) * 0.5;
        }
            break;
        case SFPlacePositionFooter:{
            y = contentY + (contentHeight - componentHeight);
        }
            break;
    }
    return y;
}

- (CGSize)componentBoundSizeThatFits:(CGSize)size {
    //优先使用指定的值,没有指定值再使用布局时传入的值
    CGFloat width = self.width?:size.width;
    CGFloat height = self.height?:size.height;
    //布局空间大小为0
    if (width <= 0 || height <= 0) {
        if (CGRectGetWidth(_customView.bounds) <= 0 || CGRectGetHeight(_customView.bounds) <= 0) {
            return CGSizeZero;
        }
        width = width?:CGRectGetWidth(_customView.bounds);
        height = height?:CGRectGetHeight(_customView.bounds);
    }
    //是否需要自适应布局
    BOOL widthLayoutFit = self.widthLayoutMode == SFPlaceLayoutModeFit || width == CGFLOAT_MAX;
    BOOL heightLayoutFit = self.heightLayoutMode == SFPlaceLayoutModeFit || height == CGFLOAT_MAX;
    if (widthLayoutFit || heightLayoutFit) {
        CGSize componentBoundSize = CGSizeZero;
        if (_customView) {
            componentBoundSize = [_customView sizeThatFits:CGSizeMake(width, height)];
        }
        else {
            componentBoundSize = [self.component componentViewBoundSizeThatFits:CGSizeMake(width, height)];
        }
        if (widthLayoutFit) {
            width = componentBoundSize.width;
        }
        if (heightLayoutFit) {
            height = componentBoundSize.height;
        }
    }
    return CGSizeMake(width, height);
}

- (void)setTop:(CGFloat)top {
    _top = top;
    _insets.top = top;
}

- (void)setLeft:(CGFloat)left {
    _left = left;
    _insets.left = left;
}

- (void)setBottom:(CGFloat)bottom {
    _bottom = bottom;
    _insets.bottom = bottom;
}

- (void)setRight:(CGFloat)right {
    _right = right;
    _insets.right = right;
}

- (void)setInsets:(UIEdgeInsets)insets {
    _insets = insets;
    _top = insets.top;
    _left = insets.left;
    _bottom = insets.bottom;
    _right = insets.right;
}

- (BOOL)visible {
    return (_component && [_component componentViewShouldDisplay]) || (_width > 0 && _height > 0) || _customView;
}

- (UIView *)renderView {
    return _customView?:_component.view;
}

SFAssemblyPlaceComponentGetter(SFViewComponent,view)

SFAssemblyPlaceComponentGetter(SFLabelComponent,label)

SFAssemblyPlaceComponentGetter(SFButtonComponent,button)

SFAssemblyPlaceComponentGetter(SFSwitchComponent, switcher)

SFAssemblyPlaceComponentGetter(SFImageViewComponent,imageView)

SFAssemblyPlaceComponentGetter(SFTextFieldComponent, textField)

SFAssemblyPlaceComponentGetter(SFAssemblyViewComponent, assembly)

@end
