//
//  SFAssemblyEasyFormLayout.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/7.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFAssemblyEasyFormLayout.h"

@implementation SFAssemblyEasyFormLayout

- (CGSize)sizeThatFits:(CGSize)size {
    //旧版本代码
    CGFloat containerWidth = size.width;
    CGFloat containerHeight = size.height;
    CGFloat maxWidth = containerWidth;
    CGFloat maxHeight = containerHeight;
    BOOL headerDisplay = self.title.visible;
    BOOL subHeaderDisplay = self.subTitle.visible;
    BOOL contentDisplay = self.content.visible;
    BOOL subFooterDisplay = self.subDetail.visible;
    BOOL footerDisplay = self.detail.visible;
    BOOL cornerDisplay = NO;
    CGSize headerSize = CGSizeZero;
    if (headerDisplay) {
        headerSize = [self.title componentBoundSizeThatFits:CGSizeMake(maxWidth, maxHeight)];
        maxWidth -= headerSize.width;
    }
    CGRect headerFrame = CGRectMake(0, 0, headerSize.width, headerSize.height);
    
    CGFloat subHeaderX = CGRectGetMaxX(headerFrame);
    CGSize subHeaderSize = CGSizeZero;
    if (subHeaderDisplay) {
        if (headerDisplay) {
            subHeaderX += self.subTitle.left;
            maxWidth -= self.subTitle.left;
        }
        subHeaderSize = [self.subTitle componentBoundSizeThatFits:CGSizeMake(maxWidth, maxHeight)];
        maxWidth -= subHeaderSize.width;
    }
    CGRect subHeaderFrame = CGRectMake(subHeaderX, 0, subHeaderSize.width, subHeaderSize.height);
    
    CGFloat footerX = containerWidth;
    CGSize footerSize = CGSizeZero;
    if (footerDisplay) {
        footerSize = [self.detail componentBoundSizeThatFits:CGSizeMake(maxWidth, maxHeight)];
        footerX -= footerSize.width;
        maxWidth -= footerSize.width;
    }
    CGRect footerFrame = CGRectMake(footerX, 0, footerSize.width, footerSize.height);
    
    CGFloat subFooterX = CGRectGetMinX(footerFrame);
    CGSize subFooterSize = CGSizeZero;
    if (subFooterDisplay) {
        if (footerDisplay) {
            subFooterX -= self.subDetail.left;
            maxWidth -= self.subDetail.left;
        }
        subFooterSize = [self.subDetail componentBoundSizeThatFits:CGSizeMake(maxWidth, maxHeight)];
        subFooterX -= subFooterSize.width;
    }
    CGRect subFooterFrame = CGRectMake(subFooterX, 0, subFooterSize.width, subFooterSize.height);
    
    CGFloat contentX = CGRectGetMaxX(subHeaderFrame);
    CGSize contentSize = CGSizeZero;
    if (contentDisplay) {
        if (headerDisplay || subHeaderDisplay) {
            contentX += self.content.left;
            maxWidth -= self.content.left;
        }
        if (footerDisplay || subFooterDisplay) {
            maxWidth -= self.content.right;
        }
        contentSize = [self.content componentBoundSizeThatFits:CGSizeMake(maxWidth, maxHeight)];
        if (maxWidth > contentSize.width) {
            contentX = [self.content componentXWithComponentWidth:contentSize.width
                                                         contentX:contentX
                                                     contentWidth:maxWidth];
        }
    }
    CGRect contentFrame = CGRectMake(contentX, 0, contentSize.width, contentSize.height);
    
    self.title.frame = headerFrame;
    self.subTitle.frame = subHeaderFrame;
    self.content.frame = contentFrame;
    self.subDetail.frame = subFooterFrame;
    self.detail.frame = footerFrame;
    
    //计算高度
    if (containerHeight == CGFLOAT_MAX) {
        NSMutableArray *validHeights = [NSMutableArray new];
        NSMutableArray *invalidPlaces = [NSMutableArray new];
        void (^block)(SFAssemblyPlace *place) = ^(SFAssemblyPlace *place) {
            if (place && CGRectGetHeight(place.frame) > 0) {
                if (CGRectGetHeight(place.frame) < CGFLOAT_MAX) {
                    [validHeights addObject:@(CGRectGetHeight(place.frame))];
                }
                else {
                    [invalidPlaces addObject:place];
                }
            }
        };
        block(self.title);
        block(self.subTitle);
        block(self.content);
        block(self.subDetail);
        block(self.detail);
        
        containerHeight = self.minHeight;
        if (validHeights.count > 0) {
            containerHeight = MAX(containerHeight, [[validHeights valueForKeyPath:@"@max.floatValue"] floatValue]);
        }
        [invalidPlaces enumerateObjectsUsingBlock:^(SFAssemblyPlace *place, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect frame = place.frame;
            frame.size.height = containerHeight;
            place.frame = frame;
        }];
    }
    
    //角标
    if (cornerDisplay) {
    }
    
    //调整Y
    void (^adjustY)(SFAssemblyPlace *place) = ^(SFAssemblyPlace *place) {
        if (place && CGRectGetHeight(place.frame) < containerHeight) {
            CGRect frame = place.frame;
            frame.origin.y = [place componentYWithComponentHeight:CGRectGetHeight(place.frame)
                                                         contentY:frame.origin.y
                                                    contentHeight:containerHeight];
            place.frame = frame;
        }
    };
    adjustY(self.title);
    adjustY(self.subTitle);
    adjustY(self.content);
    adjustY(self.subDetail);
    adjustY(self.detail);
    
    return CGSizeMake(containerWidth, containerHeight);
}

SFAssemblyLayoutPlaceGetterWithConfiguration(SFAssemblyPlace, title, ({
    
}));

SFAssemblyLayoutPlaceGetterWithConfiguration(SFAssemblyPlace, subTitle, ({
    
}));

SFAssemblyLayoutPlaceGetterWithConfiguration(SFAssemblyPlace, content, ({
    _content.left = 15;
    _content.right = 15;
}));

SFAssemblyLayoutPlaceGetterWithConfiguration(SFAssemblyPlace, detail, ({
    
}));

SFAssemblyLayoutPlaceGetterWithConfiguration(SFAssemblyPlace, subDetail, ({
    
}));

SFAssemblyLayoutPlaceGetterWithConfiguration(SFAssemblyPlace, leftAccessory, ({
    
}));

SFAssemblyLayoutPlaceGetterWithConfiguration(SFAssemblyPlace, rightAccessory, ({
    
}));

@end
