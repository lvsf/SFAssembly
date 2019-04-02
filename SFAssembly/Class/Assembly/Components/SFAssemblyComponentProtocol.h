//
//  SFAssemblyComponentProtocol.h
//  SFAssembly
//
//  Created by YunSL on 2019/1/21.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SFAssemblyComponentProtocol <NSObject>
@property (nonatomic,weak) UIView *view;
+ (UIView *)componentView;
- (CGSize)componentViewBoundSizeThatFits:(CGSize)size;
- (void)componentViewDidLoad:(UIView *)view;
- (void)componentViewWillAppear:(UIView *)view;
- (BOOL)componentViewShouldDisplay;
@end

NS_ASSUME_NONNULL_END
