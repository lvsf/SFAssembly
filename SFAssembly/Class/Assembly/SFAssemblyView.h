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

@interface SFAssemblyLayoutManager : NSObject
@property (nonatomic,strong) SFAssemblyLayout *layout;
- (CGSize)sizeThatFits:(CGSize)size;
@end

@interface SFAssemblyView : UIView
@property (nonatomic,strong) SFAssemblyLayout *layout;
@property (nonatomic,strong) SFAssemblyLayoutManager *layoutManager;
- (void)udpate;
@end

NS_ASSUME_NONNULL_END
