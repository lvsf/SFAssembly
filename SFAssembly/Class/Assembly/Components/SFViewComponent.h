//
//  SFViewComponent.h
//  SFAssembly
//
//  Created by YunSL on 2019/1/21.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SFAssemblyComponentProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFViewComponent : NSObject<SFAssemblyComponentProtocol>
@property (nonatomic,strong) UIColor *backgroundColor;
@property (nonatomic) UIViewContentMode contentMode;
@property (nonatomic) BOOL hidden;
@property (nonatomic) BOOL clipsToBounds;
@property (nonatomic) BOOL userInteractionEnabled;
@end

NS_ASSUME_NONNULL_END
