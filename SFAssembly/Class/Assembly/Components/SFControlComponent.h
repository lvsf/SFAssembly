//
//  SFControlComponent.h
//  SFAssembly
//
//  Created by YunSL on 2019/1/24.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFViewComponent.h"

@interface UIControl(SFControlComponent)
- (void)control_addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;
- (void)control_setBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;
- (BOOL)control_respondToControlEvents:(UIControlEvents)controlEvents;
@end

NS_ASSUME_NONNULL_BEGIN

@interface SFControlComponent : SFViewComponent
@property(nonatomic,getter=isEnabled) BOOL enabled;
@property(nonatomic,getter=isSelected) BOOL selected;
@property(nonatomic,getter=isHighlighted) BOOL highlighted;
@property(nonatomic) UIControlContentVerticalAlignment contentVerticalAlignment;
@property(nonatomic) UIControlContentHorizontalAlignment contentHorizontalAlignment;
@end

NS_ASSUME_NONNULL_END
