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

- (CGSize)componentBoundSizeThatFits:(CGSize)size {
    if (size.width <= 0 || size.height <= 0) {
        return CGSizeZero;
    }
    CGFloat width = self.width;
    CGFloat height = self.height;
    if (width <= 0 || height <= 0) {
        if (width <= 0) {
            width = size.width;
        }
        if (height <= 0) {
            height = size.height;
        }
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
