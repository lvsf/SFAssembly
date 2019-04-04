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
@property (nonatomic,assign) CGSize lastLayoutContainerSize;
@end

@implementation SFAssemblyLayout

- (instancetype)init {
    if (self = [super init]) {
        _needsLayout = YES;
        _lastLayoutContainerSize = CGSizeMake(-1, -1);
    }
    return self;
}

- (void)setNeedsLayout {
    _needsLayout = YES;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat width = size.width?:self.container.width;
    CGFloat height = size.height?:self.container.height;
    CGFloat contentBoundWidth = 0;
    CGFloat contentBoundHeight = 0;
    if (width > 0 && height > 0) {
        contentBoundWidth = width - self.container.insets.left - self.container.insets.right;
        contentBoundHeight = height - self.container.insets.top - self.container.insets.bottom;
        if ([self respondsToSelector:@selector(assemblyLayout:sizeThatFits:)]) {
            CGSize contentBoundSize = [self assemblyLayout:self
                                              sizeThatFits:CGSizeMake(contentBoundWidth,contentBoundHeight)];
            BOOL widthLayoutFit = self.container.widthLayoutMode == SFComponentLayoutModeFit || width == CGFLOAT_MAX;
            BOOL heightLayoutFit = self.container.heightLayoutMode == SFComponentLayoutModeFit || height == CGFLOAT_MAX;
            if (widthLayoutFit) {
                contentBoundWidth = contentBoundSize.width;
            }
            if (heightLayoutFit) {
                contentBoundHeight = contentBoundSize.height;
            }
        }
    }
    return CGSizeMake(contentBoundWidth + self.container.insets.left + self.container.insets.right,
                      contentBoundHeight + self.container.insets.top + self.container.insets.bottom);
}

- (void)sizeToFit {
    CGSize containerSize = CGSizeMake(self.container.width, self.container.height);
    BOOL needLayout = !CGSizeEqualToSize(_lastLayoutContainerSize, containerSize);
    if (!needLayout && _needsLayout) {
        _needsLayout = NO;
        needLayout = YES;
    }
    if (needLayout) {
        _size = [self sizeThatFits:containerSize];
        _container.frame = CGRectMake(self.container.insets.left,
                                      self.container.insets.top,
                                      _size.width - self.container.insets.left - self.container.insets.right,
                                      _size.height - self.container.insets.top - self.container.insets.bottom);
    }
    _lastLayoutContainerSize = containerSize;
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

- (SFAssemblyLayoutContainer *)container {
    return _container?:({
        _container = [SFAssemblyLayoutContainer new];
        _container;
    });
}

@end
