//
//  UIView+SFAddComponent.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "UIView+SFAddComponent.h"
#import <objc/runtime.h>

@implementation UIView (SFAddComponent)

- (void)setSf_component:(SFFormViewComponent *)sf_component {
    objc_setAssociatedObject(self, @selector(sf_component), sf_component, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SFFormViewComponent *)sf_component {
    return objc_getAssociatedObject(self, _cmd);
}

@end
