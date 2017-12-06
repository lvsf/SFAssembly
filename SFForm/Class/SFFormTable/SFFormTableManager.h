//
//  SFFormTableManager.h
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormManager.h"
#import "SFFormTableSection.h"
#import "SFFormTableItem.h"

@interface SFFormTableManager : SFFormManager<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) CGFloat tableViewWidth;
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,copy) NSArray <NSString *> *sectionIndexTitles;
@end
