//
//  SFFormAssemblyNormalLayout.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormAssemblyNormalLayout.h"
#import "SFFormTableNormalItem.h"

@implementation SFFormAssemblyNormalLayout
@synthesize boundSize = _boundSize;

- (CGSize)layoutWithAssemblyPart:(id<SFFormAssemblyNormalProtocol>)assemblyPart maxSize:(CGSize)size {
    CGFloat containerWidth = size.width - assemblyPart.containerInsets.left - assemblyPart.containerInsets.right;
    CGFloat containerHeight = size.height;
    if (containerHeight < CGFLOAT_MAX) {
        containerHeight = containerHeight - assemblyPart.containerInsets.top - assemblyPart.containerInsets.bottom - 1;
    }
    CGFloat maxWidth = containerWidth;
    CGFloat maxHeight = containerHeight;
    CGFloat contentSpacing = assemblyPart.contentSpacing;
    CGFloat supportSpacing = assemblyPart.supportSpacing;
    BOOL headerDisplay = [self shouldDisplayComponent:[assemblyPart headerComponent]];
    BOOL subHeaderDisplay = [self shouldDisplayComponent:[assemblyPart subHeaderComponent]];
    BOOL contentDisplay = [self shouldDisplayComponent:[assemblyPart contentComponent]];
    BOOL subFooterDisplay = [self shouldDisplayComponent:[assemblyPart subFooterComponent]];
    BOOL footerDisplay = [self shouldDisplayComponent:[assemblyPart footerComponent]];
    
    CGSize headerSize = CGSizeZero;
    if (headerDisplay) {
        headerSize = [self sizeWithComponent:[assemblyPart headerComponent] maxSize:CGSizeMake(maxWidth, maxHeight)];
        maxWidth -= headerSize.width;
    }
    CGRect headerFrame = CGRectMake(0, 0, headerSize.width, headerSize.height);
    
    CGFloat subHeaderX = CGRectGetMaxX(headerFrame);
    CGSize subHeaderSize = CGSizeZero;
    if (subHeaderDisplay) {
        if (headerDisplay) {
            subHeaderX += supportSpacing;
            maxWidth -= supportSpacing;
        }
        subHeaderSize = [self sizeWithComponent:[assemblyPart subHeaderComponent] maxSize:CGSizeMake(maxWidth, maxHeight)];
        maxWidth -= subHeaderSize.width;
    }
    CGRect subHeaderFrame = CGRectMake(subHeaderX, 0, subHeaderSize.width, subHeaderSize.height);
    
    CGFloat footerX = containerWidth;
    CGSize footerSize = CGSizeZero;
    if (footerDisplay) {
        footerSize = [self sizeWithComponent:[assemblyPart footerComponent] maxSize:CGSizeMake(maxWidth, maxHeight)];
        footerX -= footerSize.width;
        maxWidth -= footerSize.width;
    }
    CGRect footerFrame = CGRectMake(footerX, 0, footerSize.width, footerSize.height);
    
    CGFloat subFooterX = CGRectGetMinX(footerFrame);
    CGSize subFooterSize = CGSizeZero;
    if (subFooterDisplay) {
        if (footerDisplay) {
            subFooterX -= supportSpacing;
            maxWidth -= supportSpacing;
        }
        subFooterSize = [self sizeWithComponent:[assemblyPart subFooterComponent] maxSize:CGSizeMake(maxWidth, maxHeight)];
        subFooterX -= subFooterSize.width;
    }
    CGRect subFooterFrame = CGRectMake(subFooterX, 0, subFooterSize.width, subFooterSize.height);
    
    CGFloat contentX = CGRectGetMaxX(subHeaderFrame);
    CGSize contentSize = CGSizeZero;
    if (contentDisplay) {
        if (headerDisplay || subHeaderDisplay) {
            contentX += contentSpacing;
            maxWidth -= contentSpacing;
        }
        if (footerDisplay || subFooterDisplay) {
            maxWidth -= contentSpacing;
        }
        contentSize = [self sizeWithComponent:[assemblyPart contentComponent] maxSize:CGSizeMake(maxWidth, maxHeight)];
        if (maxWidth > contentSize.width) {
            switch ([assemblyPart contentComponent].horizontalPosition) {
                case SFFormComponentPositionHeader:{}break;
                case SFFormComponentPositionCenter:contentX += (maxWidth - contentSize.width) * 0.5;break;
                case SFFormComponentPositionFooter:contentX += (maxWidth - contentSize.width);break;
                default:break;
            }
        }
    }
    CGRect contentFrame = CGRectMake(contentX, 0, contentSize.width, contentSize.height);
    
    [assemblyPart headerComponent].componentViewFrame = headerFrame;
    [assemblyPart subHeaderComponent].componentViewFrame = subHeaderFrame;
    [assemblyPart contentComponent].componentViewFrame = contentFrame;
    [assemblyPart subFooterComponent].componentViewFrame = subFooterFrame;
    [assemblyPart footerComponent].componentViewFrame = footerFrame;
    
    //计算高度
    if (containerHeight == CGFLOAT_MAX) {
        NSMutableArray *validHeights = [NSMutableArray new];
        NSMutableArray *invalComponents = [NSMutableArray new];
        void (^block)(SFFormViewComponent *component) = ^(SFFormViewComponent *component){
            if (component && CGRectGetHeight(component.componentViewFrame) > 0) {
                if (CGRectGetHeight(component.componentViewFrame) < CGFLOAT_MAX) {
                    [validHeights addObject:@(CGRectGetHeight(component.componentViewFrame))];
                }
                else {
                    [invalComponents addObject:component];
                }
            }
        };
        block(assemblyPart.headerComponent);
        block(assemblyPart.subHeaderComponent);
        block(assemblyPart.contentComponent);
        block(assemblyPart.subFooterComponent);
        block(assemblyPart.footerComponent);
        
        if (validHeights.count > 0) {
            containerHeight = [[validHeights valueForKeyPath:@"@max.floatValue"] floatValue];
        }
        else {
            containerHeight = 44 - (assemblyPart.containerInsets.top + assemblyPart.containerInsets.bottom + 1);
        }
        [invalComponents enumerateObjectsUsingBlock:^(SFFormViewComponent *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect frame = obj.componentViewFrame;
            frame.size.height = containerHeight;
            obj.componentViewFrame = frame;
        }];
    }
    
    //调整Y
    void (^adjustY)(SFFormViewComponent *component) = ^(SFFormViewComponent *component) {
        if (component && CGRectGetHeight(component.componentViewFrame) < containerHeight) {
            CGRect frame = component.componentViewFrame;
            switch (component.verticalPosition) {
                case SFFormComponentPositionHeader:{}break;
                case SFFormComponentPositionCenter:frame.origin.y = (containerHeight - CGRectGetHeight(component.componentViewFrame)) * 0.5;break;
                case SFFormComponentPositionFooter:frame.origin.y = (containerHeight - CGRectGetHeight(component.componentViewFrame));break;
                default:break;
            }
            component.componentViewFrame = frame;
        }
    };
    adjustY(assemblyPart.headerComponent);
    adjustY(assemblyPart.subHeaderComponent);
    adjustY(assemblyPart.contentComponent);
    adjustY(assemblyPart.subFooterComponent);
    adjustY(assemblyPart.footerComponent);
    
    _boundSize = CGSizeMake(size.width, containerHeight + assemblyPart.containerInsets.top + assemblyPart.containerInsets.bottom + 1);
    return _boundSize;
}

- (BOOL)shouldDisplayComponent:(SFFormViewComponent*)component {
    BOOL shouldDisplay = (component != nil);
    if ([component respondsToSelector:@selector(componentViewShouldDisplay)]) {
        shouldDisplay = [component componentViewShouldDisplay];
    }
    return (shouldDisplay || (component.width > 0 && component.height > 0));
}

- (CGSize)sizeWithComponent:(SFFormViewComponent*)component maxSize:(CGSize)size {
    CGSize componentBoundSize = CGSizeZero;
    if ([self shouldDisplayComponent:component]) {
        CGFloat maxWidth = MAX(0, size.width);
        CGFloat maxHeight = MAX(0, size.height);
        if (component.width > 0) {
            maxWidth = MIN(component.width, maxWidth);
        }
        if (component.height > 0) {
            maxHeight = MIN(component.height, maxHeight);
        }
        if ([component respondsToSelector:@selector(componentView:boundSizeThatFits:)]) {
            componentBoundSize = [component componentView:component.componentView boundSizeThatFits:CGSizeMake(maxWidth, maxHeight)];
        }
        if (component.width > 0) {
            componentBoundSize.width = maxWidth;
        }
        if (component.height > 0) {
            componentBoundSize.height = maxHeight;
        }
    }
    return componentBoundSize;
}

@end
