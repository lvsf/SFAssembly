//
//  SFTableAssemblyItem.h
//  SFAssembly
//
//  Created by YunSL on 2019/4/2.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFTableItem.h"
#import "SFAssemblyLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFTableAssemblyItem : SFTableItem
@property (nonatomic,strong) SFAssemblyLayout *layout;
@end

NS_ASSUME_NONNULL_END
