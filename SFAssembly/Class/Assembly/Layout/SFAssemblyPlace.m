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
    //指定宽高
    CGFloat width = 0;
    CGFloat height = 0;
    //布局宽高
    CGFloat layoutWidth = self.width;
    CGFloat layoutHeight = self.height;
    if (layoutWidth <= 0) {
        layoutWidth = self.maxWidth?:size.width;
        if (layoutWidth <= 0 && _customView) {
            layoutWidth = CGRectGetWidth(_customView.bounds);
        }
    }
    if (layoutHeight <= 0) {
        layoutHeight = self.maxHeight?:size.height;
        if (layoutHeight <= 0 && _customView) {
            layoutHeight = CGRectGetHeight(_customView.bounds);
        }
    }
    if (layoutWidth > 0 && layoutHeight > 0) {
        width = layoutWidth;
        height = layoutHeight;
        //布局类型
        SFPlaceLayoutMode widthMode = self.widthLayoutMode;
        if (self.width > 0) {
            widthMode = SFPlaceLayoutModeFill;
        }
        else if (layoutWidth == CGFLOAT_MAX) {
            widthMode = SFPlaceLayoutModeFit;
        }
        SFPlaceLayoutMode heigtMode = self.heightLayoutMode;
        if (self.height > 0) {
            heigtMode = SFPlaceLayoutModeFill;
        }
        else if (layoutHeight == CGFLOAT_MAX) {
            heigtMode = SFPlaceLayoutModeFit;
        }
        //宽高自适应布局
        if (widthMode == SFPlaceLayoutModeFit || heigtMode == SFPlaceLayoutModeFit) {
            CGSize componentBoundSize = CGSizeZero;
            if (_customView) {
                componentBoundSize = [_customView sizeThatFits:CGSizeMake(layoutWidth, layoutHeight)];
            }
            else {
                componentBoundSize = [self.component componentViewBoundSizeThatFits:CGSizeMake(width, height)];
            }
            if (widthMode == SFPlaceLayoutModeFit) {
                width = componentBoundSize.width;
            }
            if (heigtMode == SFPlaceLayoutModeFit) {
                height = componentBoundSize.height;
            }
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
    return (_component && [_component componentViewShouldDisplay]) || (_maxWidth > 0 && _maxHeight > 0) || _customView;
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
