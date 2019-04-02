//
//  UITableViewCell+SFForm.h
//  SFFormView
//
//  Created by YunSL on 17/10/20.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFFormTableItem.h"

@protocol SFFormTableViewCellProtocol <NSObject>
@optional
- (void)cellDidLoad:(SFFormTableItem *)item;
- (void)cellWillAppear:(SFFormTableItem *)item;
@end

@interface UITableViewCell (SFForm)
@property (nonatomic,strong) SFFormTableItem *form_item;
@property (nonatomic,assign) BOOL form_isLoad;
- (void)form_reload;
@end
