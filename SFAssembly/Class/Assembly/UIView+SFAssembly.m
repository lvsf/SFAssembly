//
//  UIView+SFAssembly.m
//  SFAssembly
//
//  Created by YunSL on 2019/1/22.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "UIView+SFAssembly.h"
#import <objc/runtime.h>

@implementation UIView (SFAssembly)

- (void)setComponent:(id<SFAssemblyComponentProtocol>)component {
    objc_setAssociatedObject(self, @selector(component), component, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<SFAssemblyComponentProtocol>)component {
    return objc_getAssociatedObject(self, @selector(component));
}

@end
