//
//  SFFormControlComponent.h
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormViewComponent.h"

@interface SFFormControlComponent : SFFormViewComponent
@property(nonatomic,getter=isEnabled) BOOL enabled;
@property(nonatomic,getter=isSelected) BOOL selected;
@property(nonatomic,getter=isHighlighted) BOOL highlighted;
@property(nonatomic) UIControlContentVerticalAlignment contentVerticalAlignment;
@property(nonatomic) UIControlContentHorizontalAlignment contentHorizontalAlignment;
@end
