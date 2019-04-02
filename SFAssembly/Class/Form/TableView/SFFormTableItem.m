//
//  SFFormTableItem.m
//  SFFormView
//
//  Created by YunSL on 17/10/19.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFFormTableItem.h"

@implementation SFFormTableItem

- (instancetype)init {
    if (self = [super init]) {
        self.cacheHeight = YES;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.separatorInset = UIEdgeInsetsZero;
    }
    return self;
}

@end
