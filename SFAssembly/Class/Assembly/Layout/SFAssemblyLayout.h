//
//  SFAssemblyLayout.h
//  SFAssembly
//
//  Created by YunSL on 2019/1/22.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFAssemblyLayoutContainer.h"

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
- (CGSize)assemblyLayout:(SFAssemblyLayout *)layout sizeThatFits:(CGSize)size;
@end

@interface SFAssemblyLayout : NSObject<SFAssemblyLayoutProtocol>
@property (nonatomic,strong) SFAssemblyLayoutContainer *container;
@property (nonatomic,assign,readonly) CGSize size;
@property (nonatomic,assign,readonly) BOOL needsLayout;
- (void)addPlace:(SFAssemblyPlace *)place;
- (void)setNeedsLayout;
- (void)sizeToFit;
- (CGSize)sizeThatFits:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
