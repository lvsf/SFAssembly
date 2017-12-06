//
//  SFFormTableAssemblyCell.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormTableAssemblyCell.h"
#import "SFFormTableAssemblyItem.h"
#import "UIView+SFAddComponent.h"

static inline NSString *SFFormKeyWithComponent(SFFormViewComponent *component) {
    return NSStringFromClass([component class]);
};

@interface SFFormTableAssemblyCell()
@property (nonatomic,strong) NSMutableDictionary <NSString*,NSMutableArray*>*reusableComponentViews;
@property (nonatomic,strong) NSMutableArray <UIView*>*visibleComponentViews;
@property (nonatomic,strong) UIView *container;
@end

@implementation SFFormTableAssemblyCell

#pragma mark - life
- (void)prepareForReuse {
    [super prepareForReuse];
    [self clear];
}

- (CGSize)sizeThatFits:(CGSize)size {
    SFFormTableAssemblyItem *assemblyItem = (SFFormTableAssemblyItem*)self.sf_item;
    CGSize boundSize = assemblyItem.layout.boundSize;
    if (assemblyItem.needLayout) {
        if ([assemblyItem.layout respondsToSelector:@selector(layoutWithAssemblyPart:maxSize:)]) {
            CGFloat maxHeight = assemblyItem.expectHeight;
            if (maxHeight <= 0) {
                maxHeight = size.height;
            }
            if (maxHeight <= 0) {
                maxHeight = CGFLOAT_MAX;
            }
            boundSize = [assemblyItem.layout layoutWithAssemblyPart:assemblyItem
                                                            maxSize:CGSizeMake(size.width, maxHeight)];
        }
        assemblyItem.needLayout = NO;
    }
    return boundSize;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    SFFormTableAssemblyItem *assemblyItem = (SFFormTableAssemblyItem*)self.sf_item;
    [self.container setFrame:CGRectMake(assemblyItem.containerInsets.left, assemblyItem.containerInsets.top, CGRectGetWidth(self.contentView.bounds) - assemblyItem.containerInsets.left - assemblyItem.containerInsets.right, CGRectGetHeight(self.contentView.bounds) - assemblyItem.containerInsets.top - assemblyItem.containerInsets.bottom)];
    [[assemblyItem allComponents] enumerateObjectsUsingBlock:^(SFFormViewComponent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.componentView setFrame:obj.componentViewFrame];
    }];
}

#pragma mark - SFTableViewCellProtocol
- (void)cellDidLoad:(SFFormTableAssemblyItem *)item {
    [self.contentView addSubview:self.container];
}

- (void)cellWillAppear:(SFFormTableAssemblyItem *)item {
    [item.allComponents enumerateObjectsUsingBlock:^(SFFormViewComponent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = [self dequeueReusableViewWithComponent:obj];
        if (view == nil) {
            view = [self createViewWithComponent:obj];
            if ([obj respondsToSelector:@selector(componentViewDidLoad:)]) {
                [obj componentViewDidLoad:view];
            }
        }
        if ([obj respondsToSelector:@selector(componentViewWillAppear:)]) {
            [obj componentViewWillAppear:view];
        }
        [self.visibleComponentViews addObject:view];
    }];
}

#pragma mark - pravite
- (void)clear {
    [self.visibleComponentViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = YES;
        NSString *key = SFFormKeyWithComponent(obj.sf_component);
        NSMutableArray *views = self.reusableComponentViews[key];
        if (views == nil) {
            views = [NSMutableArray new];
            self.reusableComponentViews[key] = views;
        }
        [views addObject:obj];
    }];
    [self.visibleComponentViews removeAllObjects];
}

- (UIView*)createViewWithComponent:(SFFormViewComponent*)component {
    UIView *componentView = [component.class componentView];
    componentView.sf_component = component;
    component.componentView = componentView;
    [self.container addSubview:componentView];
    return componentView;
}

- (UIView*)dequeueReusableViewWithComponent:(SFFormViewComponent*)component {
    UIView *componentView = nil;
    NSMutableArray *views = self.reusableComponentViews[SFFormKeyWithComponent(component)];
    if (views.count > 0) {
        componentView = views.lastObject;
        componentView.hidden = NO;
        componentView.sf_component = component;
        component.componentView = componentView;
        [views removeLastObject];
    }
    return componentView;
}

- (UIView *)container {
    return _container?:({
        _container = [UIView new];
        _container.backgroundColor = [UIColor clearColor];
        _container;
    });
}

- (NSMutableArray<UIView *> *)visibleComponentViews {
    return _visibleComponentViews?:({
        _visibleComponentViews = [NSMutableArray new];
        _visibleComponentViews;
    });
}

- (NSMutableDictionary<NSString *,NSMutableArray *> *)reusableComponentViews {
    return _reusableComponentViews?:({
        _reusableComponentViews = [NSMutableDictionary new];
        _reusableComponentViews;
    });
}

@end
