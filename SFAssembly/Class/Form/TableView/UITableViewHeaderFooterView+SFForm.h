//
//  UITableViewHeaderFooterView+SFForm.h
//  SFAssembly
//
//  Created by YunSL on 2017/11/13.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFTableSection.h"
#import "SFFormSectionHeaderFooter.h"

@protocol SFTableAssemblyHeaderFooterViewProtocol <NSObject>
@optional
- (void)headerFooterViewDidLoad:(SFTableSection *)section
                   headerFooter:(SFFormSectionHeaderFooter *)headerFooter;
- (void)headerFooterViewWillAppear:(SFTableSection *)section
                      headerFooter:(SFFormSectionHeaderFooter *)headerFooter;
@end

@interface UITableViewHeaderFooterView (SFForm)
@property (nonatomic,assign) BOOL form_isLoad;
@property (nonatomic,strong) SFFormSectionHeaderFooter *form_headerFooter;
- (void)form_reloadForSection:(SFTableSection *)section;
@end
