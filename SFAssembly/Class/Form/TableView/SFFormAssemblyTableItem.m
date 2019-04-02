//
//  SFFormAssemblyTableItem.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/2.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFFormAssemblyTableItem.h"

@implementation SFFormAssemblyTableItem

- (instancetype)init {
    if (self = [super init]) {
        self.enforceFrameLayout = YES;
        self.className = @"SFFormAssemblyTableViewCell";
        self.reuseIdentifier = @"SFFormAssemblyTableViewCellID";
    }
    return self;
}

@end
