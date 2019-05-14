//
//  SFTableViewManager.h
//  SFAssembly
//
//  Created by YunSL on 2019/4/1.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFFormManager.h"
#import "SFTableSection.h"
#import "SFTableItem.h"
#import "SFFormConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFTableViewManager : SFFormManager<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,copy) NSArray<NSString *> *sectionIndexTitles;
+ (instancetype)managerWithTableView:(UITableView *)tableView;
+ (SFFormConfiguration *)configuration;
@end

NS_ASSUME_NONNULL_END
