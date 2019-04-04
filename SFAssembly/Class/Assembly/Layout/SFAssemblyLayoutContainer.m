//
//  SFAssemblyLayoutContainer.m
//  SFAssembly
//
//  Created by YunSL on 2019/1/22.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFAssemblyLayoutContainer.h"

@implementation SFAssemblyLayoutContainer

- (instancetype)init {
    if (self = [super init]) {
        self.widthLayoutMode = SFComponentLayoutModeFill;
        self.heightLayoutMode = SFComponentLayoutModeFit;
        self.width = CGRectGetWidth([UIScreen mainScreen].bounds);
        self.height = CGFLOAT_MAX;
        self.backgroundColor = [UIColor clearColor];
        self.containerColor = [UIColor clearColor];
    }
    return self;
}

@end
