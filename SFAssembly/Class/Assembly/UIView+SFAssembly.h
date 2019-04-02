//
//  UIView+SFAssembly.h
//  SFAssembly
//
//  Created by YunSL on 2019/1/22.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAssemblyComponentProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SFAssembly)
@property (nonatomic,strong,nullable) id<SFAssemblyComponentProtocol> component;
@end

NS_ASSUME_NONNULL_END
