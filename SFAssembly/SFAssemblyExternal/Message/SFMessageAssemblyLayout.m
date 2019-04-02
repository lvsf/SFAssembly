//
//  SFMessageAssemblyLayout.m
//  SFAssembly
//
//  Created by YunSL on 2019/1/21.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFMessageAssemblyLayout.h"

@interface SFMessageAssemblyLayout()

@end

@implementation SFMessageAssemblyLayout

SFAssemblyLayoutPlaceGetter(SFExternalAssemblyPlace,title)

SFAssemblyLayoutPlaceGetter(SFExternalAssemblyPlace,avatar)

SFAssemblyLayoutPlaceGetter(SFExternalAssemblyPlace,name);

SFAssemblyLayoutPlaceGetter(SFExternalAssemblyPlace,content);

SFAssemblyLayoutPlaceGetter(SFExternalAssemblyPlace,createDate);

SFAssemblyLayoutPlaceGetter(SFExternalAssemblyPlace,address);

SFAssemblyLayoutPlaceGetter(SFExternalAssemblyPlace,follow);

@end
