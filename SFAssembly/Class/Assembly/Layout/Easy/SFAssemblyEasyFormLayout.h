//
//  SFAssemblyEasyFormLayout.h
//  SFAssembly
//
//  Created by YunSL on 2019/4/7.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFAssemblyLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFAssemblyEasyFormLayout : SFAssemblyLayout
@property (nonatomic,assign) CGFloat minHeight;
@property (nonatomic,strong) SFAssemblyPlace *title;
@property (nonatomic,strong) SFAssemblyPlace *subTitle;
@property (nonatomic,strong) SFAssemblyPlace *content;
@property (nonatomic,strong) SFAssemblyPlace *subDetail;
@property (nonatomic,strong) SFAssemblyPlace *detail;
@property (nonatomic,strong) SFAssemblyPlace *leftAccessory;
@property (nonatomic,strong) SFAssemblyPlace *rightAccessory;
@end

NS_ASSUME_NONNULL_END
