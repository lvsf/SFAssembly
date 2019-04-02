//
//  SFFormSectionHeaderFooter.m
//  QuanYou
//
//  Created by YunSL on 2018/1/24.
//  Copyright © 2018年 YunSL. All rights reserved.
//

#import "SFFormSectionHeaderFooter.h"

@implementation SFFormSectionHeaderFooter
@synthesize topSeparator = _topSeparator;
@synthesize title = _title;
@synthesize detail = _detail;

- (BOOL)shouldLoadHeaderFooter {
    return self.places.count > 0 || (self.container.height > 0 && self.container.width > 0);
}

SFAssemblyLayoutPlaceGetter(SFAssemblyPlace,topSeparator)

SFAssemblyLayoutPlaceGetter(SFAssemblyPlace,title)

SFAssemblyLayoutPlaceGetter(SFAssemblyPlace,detail)

@end
