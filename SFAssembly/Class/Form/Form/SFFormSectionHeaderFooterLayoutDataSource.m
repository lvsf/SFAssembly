//
//  SFFormSectionHeaderFooterLayoutDataSource.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/1.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFFormSectionHeaderFooterLayoutDataSource.h"
#import "SFFormSectionHeaderFooterLayout.h"

@implementation SFFormSectionHeaderFooterLayoutDataSource

- (CGSize)assemblyLayout:(SFAssemblyLayout *)layout sizeThatFits:(CGSize)size {
    CGSize boundSize = size;
    if ([layout isMemberOfClass:[SFFormSectionHeaderFooterLayout class]]) {
        SFFormSectionHeaderFooterLayout *sectionLayout = (SFFormSectionHeaderFooterLayout *)layout;
        CGRect topSeparatorFrame = CGRectZero;
        if (sectionLayout.topSeparator.component) {
            topSeparatorFrame.size = [sectionLayout.topSeparator componentBoundSizeThatFits:CGSizeMake(boundSize.width,sectionLayout.topSeparator.height)];
        }
        CGFloat layoutHeight = size.height - CGRectGetHeight(topSeparatorFrame);
        CGFloat layoutWidth = size.width;
    
        CGRect detailFrame = CGRectMake(0, 0, 0, 0);
        CGRect titleFrame = CGRectMake(0, 0, 0, 0);
        
        if (sectionLayout.title.priority >= sectionLayout.detail.priority) {
            if (sectionLayout.title.component) {
                titleFrame.size = [sectionLayout.title componentBoundSizeThatFits:CGSizeMake(layoutWidth, layoutHeight)];
            }
            titleFrame.origin.x = [sectionLayout.title componentXWithComponentWidth:titleFrame.size.width
                                                                           contentX:0
                                                                       contentWidth:layoutWidth];
            layoutWidth -= CGRectGetWidth(titleFrame);
            
            CGFloat detaiLeft = CGRectGetWidth(titleFrame)?sectionLayout.detail.left:0;
            if (sectionLayout.detail.component) {
                layoutWidth -= detaiLeft;
                detailFrame.size = [sectionLayout.detail componentBoundSizeThatFits:CGSizeMake(layoutWidth,layoutHeight)];
            }
            detailFrame.origin.x = [sectionLayout.detail componentXWithComponentWidth:detailFrame.size.width
                                                                             contentX:CGRectGetMaxX(titleFrame) + detaiLeft
                                                                         contentWidth:layoutWidth];
        }
        else {
            if (sectionLayout.detail.component) {
                detailFrame.size = [sectionLayout.detail componentBoundSizeThatFits:CGSizeMake(layoutWidth,layoutHeight)];
            }
            layoutWidth -= CGRectGetWidth(detailFrame);
            
            CGFloat titleRight = CGRectGetWidth(detailFrame)?sectionLayout.detail.left:0;
            if (sectionLayout.title.component) {
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

@end
