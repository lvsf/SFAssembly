//
//  SFAssemblyViewComponent.h
//  SFAssembly
//
//  Created by YunSL on 2019/4/30.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFViewComponent.h"

NS_ASSUME_NONNULL_BEGIN

@class SFAssemblyLayout;
@interface SFAssemblyViewComponent : SFViewComponent
@property (nonatomic,strong) SFAssemblyLayout *layout;
@end

NS_ASSUME_NONNULL_END

