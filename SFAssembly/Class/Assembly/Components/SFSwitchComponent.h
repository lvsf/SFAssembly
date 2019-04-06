//
//  SFSwitchComponent.h
//  SFAssembly
//
//  Created by YunSL on 2019/4/5.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFControlComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFSwitchComponent : SFControlComponent
@property (nonatomic,assign) BOOL on;
- (void)setOn:(BOOL)on animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
