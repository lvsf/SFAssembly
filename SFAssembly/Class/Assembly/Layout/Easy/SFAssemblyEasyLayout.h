//
//  SFAssemblyEasyLayout.h
//  SFAssembly
//
//  Created by YunSL on 2019/4/3.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFAssemblyLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFAssemblyEasyLayout : SFAssemblyLayout
@property (nonatomic,strong,readonly) SFAssemblyPlace *topSeparator;
@property (nonatomic,strong,readonly) SFAssemblyPlace *title;
@property (nonatomic,strong,readonly) SFAssemblyPlace *detail;
@end

NS_ASSUME_NONNULL_END
