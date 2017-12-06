//
//  UITableView+SFAddForm.h
//  SFFormView
//
//  Created by YunSL on 17/10/19.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFFormTableManager.h"

@interface UITableView (SFAddForm)
@property (nonatomic,assign) BOOL sf_enable;
@property (nonatomic,strong) SFFormTableManager *sf_manager;
@end
