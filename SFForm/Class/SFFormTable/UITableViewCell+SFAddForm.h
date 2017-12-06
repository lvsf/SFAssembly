//
//  UITableViewCell+SFAddForm.h
//  SFFormView
//
//  Created by YunSL on 17/10/20.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFFormTableItem.h"

@protocol SFTableViewCellProtocol <NSObject>
@optional
- (void)cellDidLoad:(SFFormTableItem*)item;
- (void)cellWillAppear:(SFFormTableItem*)item;
@end

@interface UITableViewCell (SFAddForm)
@property (nonatomic,strong) SFFormTableItem *sf_item;
@property (nonatomic,assign) BOOL sf_isLoad;
- (void)sf_reload;
@end
