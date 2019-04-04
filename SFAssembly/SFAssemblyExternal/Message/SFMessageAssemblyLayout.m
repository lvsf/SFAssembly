//
//  SFMessageAssemblyLayout.m
//  SFAssembly
//
//  Created by YunSL on 2019/1/21.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFMessageAssemblyLayout.h"
#import "NSMutableArray+SFAssembly.h"

static inline CGFloat SFCenterYFromRect(CGRect targetRect,CGFloat height) {
    return CGRectGetMinY(targetRect) + (CGRectGetHeight(targetRect) - height) * 0.5;
};

@interface SFMessageAssemblyLayout()

@end

@implementation SFMessageAssemblyLayout

- (CGSize)assemblyLayout:(nonnull SFMessageAssemblyLayout *)layout sizeThatFits:(CGSize)size {
    layout.title.frame = (CGRect){CGPointZero,[layout.title componentBoundSizeThatFits:size]};
    layout.avatar.frame = (CGRect){0,CGRectGetMaxY(layout.title.frame) + layout.avatar.top,[layout.avatar componentBoundSizeThatFits:size]};
    
    CGSize followSize = [layout.follow componentBoundSizeThatFits:size];
    layout.follow.frame = (CGRect){size.width - followSize.width,SFCenterYFromRect(layout.avatar.frame,followSize.height),followSize};
    
    CGFloat nameMaxWidth = size.width - CGRectGetMaxX(layout.avatar.frame) - layout.name.left - layout.name.right;
    CGSize nameSize = [layout.name componentBoundSizeThatFits:CGSizeMake(nameMaxWidth, CGFLOAT_MAX)];
    layout.name.frame = (CGRect){CGRectGetMaxX(layout.avatar.frame) + layout.name.left,CGRectGetMinY(layout.avatar.frame),nameSize};
    
    CGSize addressSize = [layout.address componentBoundSizeThatFits:CGSizeMake(nameMaxWidth, CGFLOAT_MAX)];
    layout.address.frame = (CGRect){CGRectGetMinX(layout.name.frame),CGRectGetMaxY(layout.avatar.frame) - addressSize.height,addressSize};
    
    layout.content.frame = (CGRect){layout.content.left,CGRectGetMaxY(layout.avatar.frame) + layout.content.top,[layout.content componentBoundSizeThatFits:size]};
    
    return CGSizeMake(size.width, CGRectGetMaxY(layout.content.frame));
}

SFAssemblyLayoutPlaceGetter(SFExternalAssemblyPlace,title)

SFAssemblyLayoutPlaceGetter(SFExternalAssemblyPlace,avatar)

SFAssemblyLayoutPlaceGetter(SFExternalAssemblyPlace,name);

SFAssemblyLayoutPlaceGetter(SFExternalAssemblyPlace,content);

SFAssemblyLayoutPlaceGetter(SFExternalAssemblyPlace,createDate);

SFAssemblyLayoutPlaceGetter(SFExternalAssemblyPlace,address);

SFAssemblyLayoutPlaceGetter(SFExternalAssemblyPlace,follow);

@end
