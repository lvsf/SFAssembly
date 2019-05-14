//
//  SFAssemblyFormLayout.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/7.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFAssemblyFormLayout.h"

@implementation SFAssemblyFormLayout

- (CGSize)assemblyLayout:(SFAssemblyLayout *)layout sizeThatFits:(CGSize)size {
    return size;
}

SFAssemblyLayoutPlaceGetterWithConfiguration(SFAssemblyPlace, title, ({
    
}));

SFAssemblyLayoutPlaceGetterWithConfiguration(SFAssemblyPlace, subTitle, ({
    
}));

SFAssemblyLayoutPlaceGetterWithConfiguration(SFAssemblyPlace, content, ({
    
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

/*
 leftAccessory和rightAccessory优先度最高，两者同时存在由priority决定
 
 content优先度最低
 
 */
