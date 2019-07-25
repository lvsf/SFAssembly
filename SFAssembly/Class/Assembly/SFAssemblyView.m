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

@interface SFAssemblyLayoutManager()
@property (nonatomic,strong) NSMutableDictionary <NSString *,NSMutableArray *> *reusableComponentViews;
@property (nonatomic,strong) NSMutableDictionary <NSString *,NSMutableArray *> *visibleReusableComponentViews;
@property (nonatomic,strong) NSMutableArray <UIView *> *visibleCustomViews;
- (void)updateLayoutForRender;
@end

@implementation SFAssemblyLayoutManager

- (CGSize)sizeThatFits:(CGSize)size {
    [self _updateLayoutForRender:NO];
    [self.layout sizeToFitBoundSize:size];
    return self.layout.size;
}

- (void)updateLayoutForRender {
    [self _updateLayoutForRender:YES];
}

- (void)_updateLayoutForRender:(BOOL)render {
    //NSLog(@"[SFAssembly] SFAssemblyLayoutManager _updateLayout");
    NSMutableArray<SFAssemblyPlace *> *places = [NSMutableArray arrayWithArray:self.layout.places];
    if (render) {
        if (self.layout.background.visible) {
            [places addObject:self.layout.background];
        }
        [self.visibleCustomViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [self.visibleCustomViews removeAllObjects];
    }
    NSMutableDictionary *visibleReusableComponentViews = [NSMutableDictionary new];
    [places enumerateObjectsUsingBlock:^(SFAssemblyPlace * _Nonnull place, NSUInteger idx, BOOL * _Nonnull stop) {
        id <SFAssemblyComponentProtocol> component = place.component;
        if (place.visible) {
            if (place.customView) {
                [self.visibleCustomViews addObject:place.customView];
            }
            else if (component) {
                //从当前显示的控件中取可重用的控件
                UIView *view = [self _dequeueVisibleReusableViewWithComponent:component];
                //从重用池中取可重用的控件
                if (view == nil) {
                    view = [self _dequeueReusableViewWithComponent:component];
                }
                //新建控件
                if (view == nil) {
                    view = [component.class componentView];
                    //NSLog(@"[%@ new]",NSStringFromClass(component.class));
                    if ([component respondsToSelector:@selector(componentViewDidLoad:)]) {
                        [component componentViewDidLoad:view];
                    }
                }
                if ([component respondsToSelector:@selector(componentViewWillAppear:)]) {
                    [component componentViewWillAppear:view];
                }
                view.component = component;
                view.component.view = view;
                //加入当前显示控件列表
                NSString *key = SFReusableKeyForComponent(component);
                NSMutableArray *visibleReusableViews = visibleReusableComponentViews[key];
                if (visibleReusableViews == nil) {
                    visibleReusableViews = [NSMutableArray new];
                    visibleReusableComponentViews[key] = visibleReusableViews;
                }
                [visibleReusableViews addObject:view];
            }
            else {
                //空视图
            }
        }
        else {
            //不显示
        }
    }];
    //将当前显示未被重用的控件移入可重用的控件中
    [self.visibleReusableComponentViews enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSMutableArray * _Nonnull componentViews, BOOL * _Nonnull stop) {
        [componentViews enumerateObjectsUsingBlock:^(UIView * _Nonnull componentView, NSUInteger idx, BOOL * _Nonnull stop) {
            //componentView.component.view 可能为nil
            [self _pushVisibleReusableComponentViewToReusableView:componentView forKey:key];
        }];
        [componentViews removeAllObjects];
    }];
    //更新当前显示的控件列表
    [self setVisibleReusableComponentViews:visibleReusableComponentViews];
}

- (void)_pushVisibleReusableComponentViewToReusableView:(UIView *)componentView forKey:(NSString *)key {
    if (componentView && key) {
        //移出当前
        [componentView removeFromSuperview];
        //添加重用
        NSMutableArray *reusableViews = self.reusableComponentViews[key];
        if (reusableViews == nil) {
            reusableViews = [NSMutableArray new];
            self.reusableComponentViews[key] = reusableViews;
        }
        [reusableViews addObject:componentView];
        componentView.component.view = nil;
        componentView.component = nil;
    }
}

- (UIView *)_dequeueReusableViewWithComponent:(id<SFAssemblyComponentProtocol>)component {
    UIView *componentView = nil;
    NSMutableArray *views = self.reusableComponentViews[SFReusableKeyForComponent(component)];
    if (views.count > 0) {
        componentView = views.lastObject;
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

- (NSMutableArray<UIView *> *)visibleCustomViews {
    return _visibleCustomViews?:({
        _visibleCustomViews = [NSMutableArray new];
        _visibleCustomViews;
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

@implementation SFAssemblyView

- (void)udpate {
    [self.layoutManager updateLayoutForRender];
    [self.layout.places enumerateObjectsUsingBlock:^(SFAssemblyPlace * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self isEqual:obj.renderView.superview] == NO) {
            [self addSubview:obj.renderView];
        }
    }];
    [self setNeedsLayout];
    [self addSubview:self.layout.background.renderView];
    [self sendSubviewToBack:self.layout.background.renderView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.layout.places enumerateObjectsUsingBlock:^(SFAssemblyPlace * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.renderView setFrame:obj.frame];
    }];
    [self.layout.background.renderView setFrame:self.layout.background.frame];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self.layoutManager sizeThatFits:size];
}

#pragma mark - set/get
- (void)setLayout:(SFAssemblyLayout *)layout {
    _layout = layout;
    self.layoutManager.layout = layout;
}

- (SFAssemblyLayoutManager *)layoutManager {
    return _layoutManager?:({
        _layoutManager = [SFAssemblyLayoutManager new];
        _layoutManager;
    });
}

@end
