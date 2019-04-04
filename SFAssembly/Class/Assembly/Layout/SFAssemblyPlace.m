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
    if (size.width <= 0 || size.height <= 0) {
        return CGSizeZero;
    }
    //优先使用指定的值
    CGFloat width = self.width;
    CGFloat height = self.height;
    //使用布局传入的值
    if (width <= 0) {
        width = size.width;
    }
    if (height <= 0) {
        height = size.height;
    }
    if (_component && width > 0 && height > 0) {
        BOOL widthLayoutFit = self.widthLayoutMode == SFComponentLayoutModeFit || width == CGFLOAT_MAX;
        BOOL heightLayoutFit = self.heightLayoutMode == SFComponentLayoutModeFit || height == CGFLOAT_MAX;
        if (widthLayoutFit || heightLayoutFit) {
            CGSize componentBoundSize = [self.component componentViewBoundSizeThatFits:CGSizeMake(width, height)];
            if (widthLayoutFit) {
                width = componentBoundSize.width;
            }
            if (heightLayoutFit) {
                height = componentBoundSize.height;
            }
        }
    }
    return CGSizeMake(width, height);
}

SFAssemblyPlaceComponentGetter(SFViewComponent,view)

SFAssemblyPlaceComponentGetter(SFLabelComponent,label)

SFAssemblyPlaceComponentGetter(SFButtonComponent,button)

SFAssemblyPlaceComponentGetter(SFImageViewComponent,imageView)

@end
