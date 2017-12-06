//
//  UITableViewHeaderFooterView+SFAddForm.h
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/13.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFFormTableSection.h"

@protocol SFTableViewHeaderFooterViewProtocol <NSObject>
@optional
- (void)headerFooterViewDidLoad:(SFFormTableSection*)section
                   headerFooter:(SFFormSectionHeaderFooter*)headerFooter;
- (void)headerFooterViewWillAppear:(SFFormTableSection*)section
                      headerFooter:(SFFormSectionHeaderFooter*)headerFooter;
@end

@interface UITableViewHeaderFooterView (SFAddForm)
@property (nonatomic,assign) BOOL sf_isLoad;
@end
