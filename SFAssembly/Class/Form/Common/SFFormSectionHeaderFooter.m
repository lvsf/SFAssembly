//
//  SFFormSectionHeaderFooter.m
//  QuanYou
//
//  Created by YunSL on 2018/1/24.
//  Copyright © 2018年 YunSL. All rights reserved.
//

#import "SFFormSectionHeaderFooter.h"

@implementation SFFormSectionHeaderFooter

- (instancetype)init {
    if (self = [super init]) {
        _cacheHeight = YES;
    }
    return self;
}

- (BOOL)shouldLoadHeaderFooter {
    return [NSClassFromString(self.className) respondsToSelector:@selector(new)];
}

@end
