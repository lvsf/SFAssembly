//
//  SFAssemblyLayout.h
//  SFAssembly
//
//  Created by YunSL on 2019/1/22.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SFAssemblyPlace.h"

NS_ASSUME_NONNULL_BEGIN

#define SFAssemblyLayoutPlaceGetter(class,property) \
- (class *)property {\
    return _##property?:({ \
        _##property = [class new]; \
        [self addPlace:_##property]; \
        _##property; \
    });\
}

#define SFAssemblyLayoutPlaceGetterWithConfiguration(class,property,configuration) \
- (class *)property {\
    return _##property?:({ \
        _##property = [class new]; \
        [self addPlace:_##property]; \
        configuration; \
        _##property; \
        });\
}

@class SFAssemblyLayout;
@protocol SFAssemblyLayoutProtocol <NSObject>
@required
- (NSArray<SFAssemblyPlace *> *)places;
- (CGSize)sizeThatFits:(CGSize)size;
@end

@interface SFAssemblyLayout : NSObject<SFAssemblyLayoutProtocol>
@property (nonatomic,assign) UIEdgeInsets insets;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) SFPlaceLayoutMode widthLayoutMode;
@property (nonatomic,assign) SFPlaceLayoutMode heightLayoutMode;
@property (nonatomic,strong) SFAssemblyPlace *background;
@property (nonatomic,assign,readonly) CGSize size;

- (void)addPlace:(SFAssemblyPlace *)place;
- (void)setNeedsLayout;
- (void)sizeToFit;
- (void)sizeToFitBoundSize:(CGSize)size;

@end


NS_ASSUME_NONNULL_END
