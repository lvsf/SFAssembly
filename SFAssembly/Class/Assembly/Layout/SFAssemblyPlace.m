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
        self.horizontalPosition = SFComponentPositionHeader;
        self.verticalPosition = SFComponentPositionCenter;
        self.widthLayoutMode = SFComponentLayoutModeFit;
        self.heightLayoutMode = SFComponentLayoutModeFit;
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
        case SFComponentPositionHeader:{
            x = contentX;
        }
            break;
        case SFComponentPositionCenter:{
            x = contentX + (contentWidth - componentWidth) * 0.5;
        }
            break;
        case SFComponentPositionFooter:{
            x = contentX + (contentWidth - componentWidth);
        }
            break;
    }
    return x;
}

- (CGFloat)componentYWithComponentHeight:(CGFloat)componentHeight contentY:(CGFloat)contentY contentHeight:(CGFloat)contentHeight {
    CGFloat y = 0;
    switch (self.verticalPosition) {
        case SFComponentPositionHeader:{
            y = contentY;
        }
            break;
        case SFComponentPositionCenter:{
            y = contentY + (contentHeight - componentHeight) * 0.5;
        }
            break;
        case SFComponentPositionFooter:{
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
    BOOL widthLayoutFit = self.widthLayoutMode == SFComponentLayoutModeFit || width == CGFLOAT_MAX;
    BOOL heightLayoutFit = self.heightLayoutMode == SFComponentLayoutModeFit || height == CGFLOAT_MAX;
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

- (BOOL)visible {
    return _component || _customView || (_width > 0 && _height > 0);
}

SFAssemblyPlaceComponentGetter(SFViewComponent,view)

SFAssemblyPlaceComponentGetter(SFLabelComponent,label)

SFAssemblyPlaceComponentGetter(SFButtonComponent,button)

SFAssemblyPlaceComponentGetter(SFImageViewComponent,imageView)

@end
