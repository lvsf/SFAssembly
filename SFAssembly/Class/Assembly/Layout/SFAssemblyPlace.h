//
//  SFAssemblyPlace.h
//  SFAssembly
//
//  Created by YunSL on 2019/1/22.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFViewComponent.h"
#import "SFImageViewComponent.h"
#import "SFLabelComponent.h"
#import "SFButtonComponent.h"

#define SFAssemblyPlaceComponentGetter(class,property) \
- (class *)property { \
    if (_component) { \
        return _component; \
    } \
    return _##property?:({ \
        _component = [class new]; \
        _##property = _component; \
        _##property; \
    }); \
}

typedef NS_ENUM(NSInteger,SFComponentPosition) {
    SFComponentPositionHeader = 0, //置顶
    SFComponentPositionCenter,     //居中
    SFComponentPositionFooter      //置底
};

typedef NS_ENUM(NSInteger,SFComponentLayoutMode) {
    SFComponentLayoutModeFit = 0,
    SFComponentLayoutModeFill,
};

static NSInteger SFAssemblyPlacePriorityHigh = 1000;
static NSInteger SFAssemblyPlacePriorityLow = 0;

NS_ASSUME_NONNULL_BEGIN

@interface SFAssemblyPlace : NSObject{
    id<SFAssemblyComponentProtocol> _component;
}

@property (nonatomic,assign) CGRect frame;
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,assign) CGFloat left;
@property (nonatomic,assign) CGFloat right;
@property (nonatomic,assign) CGFloat bottom;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) NSInteger priority;

@property (nonatomic,assign) SFComponentLayoutMode widthLayoutMode;
@property (nonatomic,assign) SFComponentLayoutMode heightLayoutMode;
@property (nonatomic,assign) SFComponentPosition horizontalPosition;
@property (nonatomic,assign) SFComponentPosition verticalPosition;

@property (nonatomic,strong) SFViewComponent *view;
@property (nonatomic,strong) SFImageViewComponent *imageView;
@property (nonatomic,strong) SFLabelComponent *label;
@property (nonatomic,strong) SFButtonComponent *button;

@property (nonatomic,strong,readonly) id<SFAssemblyComponentProtocol> component;

@property (nonatomic,copy) void (^onLoad)(SFAssemblyPlace *place, UIView *view);

- (CGSize)componentBoundSizeThatFits:(CGSize)size;
- (CGFloat)componentXWithComponentWidth:(CGFloat)componentWidth
                               contentX:(CGFloat)contentX
                           contentWidth:(CGFloat)contentWidth;
- (CGFloat)componentYWithComponentHeight:(CGFloat)componentHeight
                                contentY:(CGFloat)contentY
                           contentHeight:(CGFloat)contentHeight;
- (void)update;

@end

NS_ASSUME_NONNULL_END
