//
//  SFAssemblyEasyLayout.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/3.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFAssemblyEasyLayout.h"

@implementation SFAssemblyEasyLayout
@synthesize topSeparator = _topSeparator;
@synthesize title = _title;
@synthesize detail = _detail;

- (CGSize)sizeThatFits:(CGSize)size {
    SFAssemblyEasyLayout *layout = self;
    CGSize boundSize = size;
    if ([layout isMemberOfClass:[SFAssemblyEasyLayout class]]) {
        SFAssemblyEasyLayout *easyLayout = (SFAssemblyEasyLayout *)layout;
        CGRect topSeparatorFrame = CGRectZero;
        if (easyLayout.topSeparator.visible) {
            topSeparatorFrame.size = [easyLayout.topSeparator componentBoundSizeThatFits:CGSizeMake(boundSize.width,easyLayout.topSeparator.height)];
        }
        CGFloat layoutHeight = size.height - CGRectGetHeight(topSeparatorFrame);
        CGFloat layoutWidth = size.width;
        
        CGRect detailFrame = CGRectMake(0, 0, 0, 0);
        CGRect titleFrame = CGRectMake(0, 0, 0, 0);
        
        if (easyLayout.title.priority >= easyLayout.detail.priority) {
            if (easyLayout.title.visible) {
                titleFrame.size = [easyLayout.title componentBoundSizeThatFits:CGSizeMake(layoutWidth, layoutHeight)];
            }
            titleFrame.origin.x = [easyLayout.title componentXWithComponentWidth:titleFrame.size.width
                                                                           contentX:0
                                                                       contentWidth:layoutWidth];
            layoutWidth -= CGRectGetMaxX(titleFrame);
            
            CGFloat detaiLeft = CGRectGetWidth(titleFrame)?easyLayout.detail.left:0;
            if (easyLayout.detail.visible) {
                layoutWidth -= detaiLeft;
                detailFrame.size = [easyLayout.detail componentBoundSizeThatFits:CGSizeMake(layoutWidth,layoutHeight)];
            }
            detailFrame.origin.x = [easyLayout.detail componentXWithComponentWidth:detailFrame.size.width
                                                                             contentX:CGRectGetMaxX(titleFrame) + detaiLeft
                                                                         contentWidth:layoutWidth];
        }
        else {
            if (easyLayout.detail.visible) {
                detailFrame.size = [easyLayout.detail componentBoundSizeThatFits:CGSizeMake(layoutWidth,layoutHeight)];
            }
            layoutWidth -= CGRectGetWidth(detailFrame);
            
            CGFloat titleRight = CGRectGetWidth(detailFrame)?easyLayout.detail.left:0;
            if (easyLayout.title.visible) {
                layoutWidth -= titleRight;
                titleFrame.size = [easyLayout.title componentBoundSizeThatFits:CGSizeMake(layoutWidth, layoutHeight)];
            }
            titleFrame.origin.x = [easyLayout.title componentXWithComponentWidth:titleFrame.size.width
                                                                           contentX:0
                                                                       contentWidth:layoutWidth];
            detailFrame.origin.x = [easyLayout.detail componentXWithComponentWidth:detailFrame.size.width
                                                                             contentX:CGRectGetMaxX(titleFrame) +titleRight
                                                                         contentWidth:layoutWidth];
        }
        
        if (layoutHeight == CGFLOAT_MAX || layout.heightLayoutMode == SFPlaceLayoutModeFit) {
            layoutHeight = CGRectGetHeight(topSeparatorFrame) + MAX(CGRectGetMaxY(detailFrame), CGRectGetMaxY(titleFrame));
        }
        
        titleFrame.origin.y = [easyLayout.title componentYWithComponentHeight:titleFrame.size.height contentY:CGRectGetMaxY(topSeparatorFrame) contentHeight:layoutHeight];
        detailFrame.origin.y = [easyLayout.title componentYWithComponentHeight:detailFrame.size.height contentY:CGRectGetMaxY(topSeparatorFrame) contentHeight:layoutHeight];
        
        easyLayout.title.frame = titleFrame;
        easyLayout.detail.frame = detailFrame;
        easyLayout.topSeparator.frame = topSeparatorFrame;
        
        boundSize.width = size.width;
        boundSize.height = layoutHeight;
    }
    if (boundSize.height == CGFLOAT_MAX) {
        boundSize.height = 0;
    }
    return boundSize;
}

SFAssemblyLayoutPlaceGetterWithConfiguration(SFAssemblyPlace, topSeparator, ({
    _topSeparator.heightLayoutMode = SFPlaceLayoutModeFill;
}))

SFAssemblyLayoutPlaceGetterWithConfiguration(SFAssemblyPlace, title, ({
    _title.priority = SFAssemblyPlacePriorityHigh;
    _title.verticalPosition = SFPlacePositionHeader;
}))

SFAssemblyLayoutPlaceGetterWithConfiguration(SFAssemblyPlace, detail, ({
    _detail.priority = SFAssemblyPlacePriorityLow;
    _detail.horizontalPosition = SFPlacePositionFooter;
}))

@end
