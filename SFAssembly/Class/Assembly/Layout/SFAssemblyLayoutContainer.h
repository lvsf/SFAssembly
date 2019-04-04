//
//  SFAssemblyLayoutContainer.h
//  SFAssembly
//
//  Created by YunSL on 2019/1/22.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFAssemblyPlace.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFAssemblyLayoutContainer : SFAssemblyPlace
@property (nonatomic,assign) UIEdgeInsets insets;
@property (nonatomic,strong) UIColor *backgroundColor;
@property (nonatomic,strong) UIColor *containerColor;
@end

NS_ASSUME_NONNULL_END
