//
//  SFAssemblyView.m
//  SFAssembly
//
//  Created by YunSL on 2019/1/21.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFAssemblyView.h"
#import "UIView+SFAssembly.h"
#import <objc/runtime.h>

static inline NSString *SFReusableKeyForComponent(id<SFAssemblyComponentProtocol> component) {
    return NSStringFromClass([component class]);
};

@interface SFAssemblyView()
@property (nonatomic,strong) NSMutableDictionary <NSString *,NSMutableArray *> *reusableComponentViews;
@property (nonatomic,strong) NSMutableDictionary <NSString *,NSMutableArray *> *visibleReusableComponentViews;
@property (nonatomic,strong) UIView *customComponentView;
@end

@implementation SFAssemblyView

#pragma mark - life
- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.contentView];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    [self.layout.container setWidth:size.width];
    [self.layout.container setHeight:size.height];
    [self.layout sizeToFit];
    return self.layout.size;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.layout.places enumerateObjectsUsingBlock:^(SFAssemblyPlace * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.customView) {
            [obj.customView setFrame:obj.frame];
        }
        else {
            [obj.component.view setFrame:obj.frame];
        }
    }];
    [self.contentView setFrame:self.layout.container.frame];
}

#pragma mark - private
- (void)_updateForHeightCalculate:(BOOL)forHeightCalculate {
    if (!forHeightCalculate) {
        [self.customComponentView removeFromSuperview];
        [self setCustomComponentView:nil];
    }
    NSMutableDictionary *visibleReusableComponentViews = [NSMutableDictionary new];
    [self.layout.places enumerateObjectsUsingBlock:^(SFAssemblyPlace * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.customView) {
            if (!forHeightCalculate) {
                [self.contentView addSubview:obj.customView];
                [self setCustomComponentView:obj.customView];
            }
        }
        else {
            if (obj.component) {
                //从当前显示的控件中取可重用的控件
                UIView *view = [self _dequeueVisibleReusableViewWithComponent:obj.component];
                //从重用池中取可重用的控件
                if (view == nil) {
                    view = [self _dequeueReusableViewWithComponent:obj.component];
                }
                //新建控件
                if (view == nil) {
                    view = [obj.component.class componentView];
                    if (!forHeightCalculate) {
                        [self.contentView addSubview:view];
                    }
                    if ([obj.component respondsToSelector:@selector(componentViewDidLoad:)]) {
                        [obj.component componentViewDidLoad:view];
                    }
                }
                if ([obj.component respondsToSelector:@selector(componentViewWillAppear:)]) {
                    [obj.component componentViewWillAppear:view];
                }
                view.component = obj.component;
                obj.component.view = view;
                NSString *key = SFReusableKeyForComponent(obj.component);
                NSMutableArray *visibleReusableViews = visibleReusableComponentViews[key];
                if (visibleReusableViews == nil) {
                    visibleReusableViews = [NSMutableArray new];
                    visibleReusableComponentViews[key] = visibleReusableViews;
                }
                [visibleReusableViews addObject:view];
            }
        }
    }];
    
    //将当前显示未被重用的控件移入可重用的控件中
    [self.visibleReusableComponentViews enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSMutableArray * _Nonnull obj, BOOL * _Nonnull stop) {
        NSMutableArray *reusableViews = self.reusableComponentViews[key];
        if (reusableViews == nil) {
            reusableViews = [NSMutableArray new];
            self.reusableComponentViews[key] = reusableViews;
        }
        [obj enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj setHidden:YES];
            [reusableViews addObject:obj];
        }];
    }];
    //更新当前显示的控件列表
    [self setVisibleReusableComponentViews:visibleReusableComponentViews];
    
    //更新容器视图
    if (!forHeightCalculate) {
        [self.contentView setBackgroundColor:self.layout.container.containerColor];
        [self setBackgroundColor:self.layout.container.backgroundColor];
    }
}

- (UIView *)_dequeueReusableViewWithComponent:(id<SFAssemblyComponentProtocol>)component {
    UIView *componentView = nil;
    NSMutableArray *views = self.reusableComponentViews[SFReusableKeyForComponent(component)];
    if (views.count > 0) {
        componentView = views.lastObject;
        componentView.hidden = NO;
        [views removeObject:componentView];
    }
    return componentView;
}

- (UIView *)_dequeueVisibleReusableViewWithComponent:(id<SFAssemblyComponentProtocol>)component {
    UIView *componentView = nil;
    NSMutableArray *views = self.visibleReusableComponentViews[SFReusableKeyForComponent(component)];
    if (views.count > 0) {
        componentView = views.firstObject;
        [views removeObject:componentView];
    }
    return componentView;
}

#pragma mark - set/get
- (void)setLayoutForHeightCalculate:(SFAssemblyLayout *)layout {
    _layout = layout;
    [self _updateForHeightCalculate:YES];
}

- (void)setLayout:(SFAssemblyLayout *)layout {
    _layout = layout;
    [self _updateForHeightCalculate:NO];
    [self setNeedsLayout];
}

- (UIView *)contentView {
    return _contentView?:({
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView;
    });
}

- (NSMutableDictionary<NSString *,NSMutableArray *> *)visibleReusableComponentViews {
    return _visibleReusableComponentViews?:({
        _visibleReusableComponentViews = [NSMutableDictionary new];
        _visibleReusableComponentViews;
    });
}

- (NSMutableDictionary<NSString *,NSMutableArray *> *)reusableComponentViews {
    return _reusableComponentViews?:({
        _reusableComponentViews = [NSMutableDictionary new];
        _reusableComponentViews;
    });
}

@end
