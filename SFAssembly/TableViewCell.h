//
//  TableViewCell.h
//  SFAssembly
//
//  Created by YunSL on 2019/4/2.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYLabel.h>
#import "UITableViewCell+SFForm.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell<SFFormTableViewCellProtocol>
@property (nonatomic,strong) YYLabel *contentLabel;
@end

NS_ASSUME_NONNULL_END
