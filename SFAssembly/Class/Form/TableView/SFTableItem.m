//
//  SFFormTableItem.m
//  SFFormView
//
//  Created by YunSL on 17/10/19.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFTableItem.h"

@implementation SFTableItem

- (instancetype)init {
    if (self = [super init]) {
        self.cacheHeight = YES;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.separatorInset = UIEdgeInsetsZero;
    }
    return self;
}

- (void)reloadData {
    if (self.tableView && self.cell) {
        [self.tableView reloadRowAtIndexPath:[self.tableView indexPathForCell:self.cell]
                            withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
