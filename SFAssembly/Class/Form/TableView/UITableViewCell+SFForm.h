//
//  UITableViewCell+SFForm.h
//  SFFormView
//
//  Created by YunSL on 17/10/20.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFTableItem.h"

@protocol SFFormTableViewCellProtocol <NSObject>
@optional
- (void)cellDidLoad:(SFTableItem *)item;
- (void)cellWillAppear:(SFTableItem *)item;
@end

@interface UITableViewCell (SFForm)
@property (nonatomic,strong) SFTableItem *form_item;
@property (nonatomic,assign) BOOL form_isLoad;
- (void)form_reload;
@end
