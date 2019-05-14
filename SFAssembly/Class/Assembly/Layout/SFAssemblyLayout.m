//
//  SFAssemblyLayout.m
//  SFAssembly
//
//  Created by YunSL on 2019/1/22.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFAssemblyLayout.h"

@interface SFAssemblyLayout()
@property (nonatomic,strong) NSMutableArray<SFAssemblyPlace *> *allPlaces;
@property (nonatomic,assign) CGSize lastLayoutContentSize;
@property (nonatomic,assign) BOOL needsLayout;
@end

@implementation SFAssemblyLayout

- (instancetype)init {
    if (self = [super init]) {
        _needsLayout = YES;
        _lastLayoutContentSize = CGSizeMake(-1, -1);
        _insets = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeZero;
}

- (void)setNeedsLayout {
    _needsLayout = YES;
}

- (void)sizeToFitBoundSize:(CGSize)size {
    CGSize boundSize = size;
    if (_width) {
        boundSize.width = _width;
    }
    if (_height) {
        boundSize.height = _height;
    }
    if (boundSize.width > 0 && boundSize.height > 0) {
        CGFloat contentWidth = boundSize.width - _insets.left - _insets.right;
        CGFloat contentHeight = boundSize.height - _insets.top - _insets.bottom;
        CGSize layoutContentSize = CGSizeMake(contentWidth, contentHeight);
        BOOL needLayout = !CGSizeEqualToSize(_lastLayoutContentSize, layoutContentSize);
        if (!needLayout && _needsLayout) {
            _needsLayout = NO;
            needLayout = YES;
        }
        if (needLayout) {
            CGSize contentSize = [self sizeThatFits:layoutContentSize];
            BOOL widthLayoutFit = _widthLayoutMode == SFPlaceLayoutModeFit || boundSize.width == CGFLOAT_MAX;
            BOOL heightLayoutFit = _heightLayoutMode == SFPlaceLayoutModeFit || boundSize.height == CGFLOAT_MAX;
            if (widthLayoutFit) {
                contentWidth = contentSize.width;
            }
            if (heightLayoutFit) {
                contentHeight = contentSize.height;
            }
            [_allPlaces enumerateObjectsUsingBlock:^(SFAssemblyPlace * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CGRect frame = obj.frame;
                frame.origin.x += self.insets.left;
                frame.origin.y += self.insets.top;
                obj.frame = frame;
            }];
            _size = CGSizeMake(contentWidth + _insets.left + _insets.right,
                               contentHeight + _insets.top + _insets.bottom);
            _background.frame = CGRectMake(_background.left,
                                           _background.top,
                                           _size.width - _background.left - _background.right,
                                           _size.height - _background.top - _background.bottom);
            _lastLayoutContentSize = layoutContentSize;
        }
    }
    else {
        _size = CGSizeMake(_insets.left + _insets.right,_insets.top + _insets.bottom);
        _background.frame = CGRectZero;
    }
}

- (void)sizeToFit {
    [self sizeToFitBoundSize:CGSizeMake(self.width, self.height)];
}

- (void)addPlace:(SFAssemblyPlace *)place {
    if (place) {
        [self.allPlaces addObject:place];
    }
}

- (NSArray<SFAssemblyPlace *> *)places {
    return _allPlaces;
}

- (CGSize)assemblyLayout:(SFAssemblyLayout *)layout sizeThatFits:(CGSize)size {
    return CGSizeZero;
}

- (NSMutableArray<SFAssemblyPlace *> *)allPlaces {
    return _allPlaces?:({
        _allPlaces = [NSMutableArray new];
        _allPlaces;
    });
}

- (SFAssemblyPlace *)background {
    return _background?:({
        _background = [SFAssemblyPlace new];
        _background;
    });
}

@end
