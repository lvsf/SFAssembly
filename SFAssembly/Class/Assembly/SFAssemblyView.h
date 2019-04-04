//
//  SFAssemblyView.h
//  SFAssembly
//
//  Created by YunSL on 2019/1/21.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAssemblyLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFAssemblyView : UIView
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) SFAssemblyLayout *layout;
- (void)setLayoutForHeightCalculate:(SFAssemblyLayout *)layout;
@end

NS_ASSUME_NONNULL_END
