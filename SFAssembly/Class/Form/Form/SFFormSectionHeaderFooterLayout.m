//
//  SFFormSectionHeaderFooterLayout.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/3.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFFormSectionHeaderFooterLayout.h"
#import "NSMutableArray+SFAssembly.h"

@implementation SFFormSectionHeaderFooterLayout
@synthesize topSeparator = _topSeparator;
@synthesize title = _title;
@synthesize detail = _detail;

- (CGSize)assemblyLayout:(SFAssemblyLayout *)layout sizeThatFits:(CGSize)size {
    CGSize boundSize = size;
    if ([layout isMemberOfClass:[SFFormSectionHeaderFooterLayout class]]) {
        SFFormSectionHeaderFooterLayout *sectionLayout = (SFFormSectionHeaderFooterLayout *)layout;
        CGRect topSeparatorFrame = CGRectZero;
        if (sectionLayout.topSeparator.visible) {
            topSeparatorFrame.size = [sectionLayout.topSeparator componentBoundSizeThatFits:CGSizeMake(boundSize.width,sectionLayout.topSeparator.height)];
        }
        CGFloat layoutHeight = size.height - CGRectGetHeight(topSeparatorFrame);
        CGFloat layoutWidth = size.width;
        
        CGRect detailFrame = CGRectMake(0, 0, 0, 0);
        CGRect titleFrame = CGRectMake(0, 0, 0, 0);
        
        if (sectionLayout.title.priority >= sectionLayout.detail.priority) {
            if (sectionLayout.title.visible) {
                titleFrame.size = [sectionLayout.title componentBoundSizeThatFits:CGSizeMake(layoutWidth, layoutHeight)];
            }
            titleFrame.origin.x = [sectionLayout.title componentXWithComponentWidth:titleFrame.size.width
                                                                           contentX:0
                                                                       contentWidth:layoutWidth];
            layoutWidth -= CGRectGetMaxX(titleFrame);
            
            CGFloat detaiLeft = CGRectGetWidth(titleFrame)?sectionLayout.detail.left:0;
            if (sectionLayout.detail.visible) {
                layoutWidth -= detaiLeft;
                detailFrame.size = [sectionLayout.detail componentBoundSizeThatFits:CGSizeMake(layoutWidth,layoutHeight)];
            }
            detailFrame.origin.x = [sectionLayout.detail componentXWithComponentWidth:detailFrame.size.width
                                                                             contentX:CGRectGetMaxX(titleFrame) + detaiLeft
                                                                         contentWidth:layoutWidth];
        }
        else {
            if (sectionLayout.detail.visible) {
                detailFrame.size = [sectionLayout.detail componentBoundSizeThatFits:CGSizeMake(layoutWidth,layoutHeight)];
            }
            layoutWidth -= CGRectGetWidth(detailFrame);
            
            CGFloat titleRight = CGRectGetWidth(detailFrame)?sectionLayout.detail.left:0;
            if (sectionLayout.title.visible) {
                layoutWidth -= titleRight;
                titleFrame.size = [sectionLayout.title componentBoundSizeThatFits:CGSizeMake(layoutWidth, layoutHeight)];
            }
            titleFrame.origin.x = [sectionLayout.title componentXWithComponentWidth:titleFrame.size.width
                                                                           contentX:0
                                                                       contentWidth:layoutWidth];
            detailFrame.origin.x = [sectionLayout.detail componentXWithComponentWidth:detailFrame.size.width
                                                                             contentX:CGRectGetMaxX(titleFrame) +titleRight
                                                                         contentWidth:layoutWidth];
        }
        
        if (layoutHeight == CGFLOAT_MAX || layout.container.heightLayoutMode == SFComponentLayoutModeFit) {
            layoutHeight = CGRectGetHeight(topSeparatorFrame) + MAX(CGRectGetMaxY(detailFrame), CGRectGetMaxY(titleFrame));
        }
        
        titleFrame.origin.y = [sectionLayout.title componentYWithComponentHeight:titleFrame.size.height contentY:CGRectGetMaxY(topSeparatorFrame) contentHeight:layoutHeight];
        detailFrame.origin.y = [sectionLayout.title componentYWithComponentHeight:detailFrame.size.height contentY:CGRectGetMaxY(topSeparatorFrame) contentHeight:layoutHeight];
        
        sectionLayout.title.frame = titleFrame;
        sectionLayout.detail.frame = detailFrame;
        sectionLayout.topSeparator.frame = topSeparatorFrame;
        
        boundSize.width = size.width;
        boundSize.height = layoutHeight;
    }
    if (boundSize.height == CGFLOAT_MAX) {
        boundSize.height = 0;
    }
    return boundSize;
}

SFAssemblyLayoutPlaceGetterWithConfiguration(SFAssemblyPlace, topSeparator, ({
    _topSeparator.heightLayoutMode = SFComponentLayoutModeFill;
}))

SFAssemblyLayoutPlaceGetterWithConfiguration(SFAssemblyPlace, title, ({
    _title.priority = SFAssemblyPlacePriorityHigh;
    _title.verticalPosition = SFComponentPositionHeader;
}))

SFAssemblyLayoutPlaceGetterWithConfiguration(SFAssemblyPlace, detail, ({
    _detail.priority = SFAssemblyPlacePriorityLow;
    _detail.horizontalPosition = SFComponentPositionFooter;
}))

@end
