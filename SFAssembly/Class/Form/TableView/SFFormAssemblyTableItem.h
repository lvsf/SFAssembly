//
//  SFFormAssemblyTableItem.h
//  SFAssembly
//
//  Created by YunSL on 2019/4/2.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFFormTableItem.h"
#import "SFAssemblyLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFFormAssemblyTableItem : SFFormTableItem
@property (nonatomic,strong) SFAssemblyLayout *layout;
@end

NS_ASSUME_NONNULL_END
