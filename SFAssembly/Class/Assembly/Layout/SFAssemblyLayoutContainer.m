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
        self.widthLayoutMode = SFPlaceLayoutModeFill;
        self.heightLayoutMode = SFPlaceLayoutModeFit;
        self.height = CGFLOAT_MAX;
    }
    return self;
}

@end
