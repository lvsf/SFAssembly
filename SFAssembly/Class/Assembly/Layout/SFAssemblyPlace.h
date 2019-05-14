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
#import "SFSwitchComponent.h"
#import "SFTextFieldComponent.h"
#import "SFAssemblyViewComponent.h"
#import "NSObject+SFEvent.h"

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

typedef NS_ENUM(NSInteger,SFPlacePosition) {
    SFPlacePositionHeader = 0, //置顶
    SFPlacePositionCenter,     //居中
    SFPlacePositionFooter      //置底
};

typedef NS_ENUM(NSInteger,SFPlaceLayoutMode) {
    SFPlaceLayoutModeFit = 0,
    SFPlaceLayoutModeFill,
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
@property (nonatomic,assign) UIEdgeInsets insets;

@property (nonatomic,assign) NSInteger priority;

@property (nonatomic,assign) SFPlaceLayoutMode widthLayoutMode;
@property (nonatomic,assign) SFPlaceLayoutMode heightLayoutMode;
@property (nonatomic,assign) SFPlacePosition horizontalPosition;
@property (nonatomic,assign) SFPlacePosition verticalPosition;

@property (nonatomic,strong) SFViewComponent *view;
@property (nonatomic,strong) SFImageViewComponent *imageView;
@property (nonatomic,strong) SFLabelComponent *label;
@property (nonatomic,strong) SFButtonComponent *button;
@property (nonatomic,strong) SFSwitchComponent *switcher;
@property (nonatomic,strong) SFTextFieldComponent *textField;
@property (nonatomic,strong) SFAssemblyViewComponent *assembly;
@property (nonatomic,strong) UIView *customView;

@property (nonatomic,strong,readonly) UIView *renderView;
@property (nonatomic,strong,readonly) id<SFAssemblyComponentProtocol> component;
@property (nonatomic,assign,readonly) BOOL visible;

@property (nonatomic,copy) void (^onLoad)(SFAssemblyPlace *place, UIView *view);

- (void)update;
- (CGSize)componentBoundSizeThatFits:(CGSize)size;
- (CGFloat)componentXWithComponentWidth:(CGFloat)componentWidth
                               contentX:(CGFloat)contentX
                           contentWidth:(CGFloat)contentWidth;
- (CGFloat)componentYWithComponentHeight:(CGFloat)componentHeight
                                contentY:(CGFloat)contentY
                           contentHeight:(CGFloat)contentHeight;
@end

NS_ASSUME_NONNULL_END
