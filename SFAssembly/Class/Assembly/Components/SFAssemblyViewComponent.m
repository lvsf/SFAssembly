//
//  SFAssemblyViewComponent.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/30.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFAssemblyViewComponent.h"
#import "SFAssemblyView.h"
#import "SFAssemblyLayout.h"

@implementation SFAssemblyViewComponent

+ (UIView *)componentView {
    return [SFAssemblyView new];
}

- (void)componentViewDidLoad:(SFAssemblyView *)view {
    [super componentViewDidLoad:view];
}

- (void)componentViewWillAppear:(SFAssemblyView *)view {
    [super componentViewWillAppear:view];
    [view setLayout:self.layout];
    [view udpate];
}

- (CGSize)componentViewBoundSizeThatFits:(CGSize)size {
    return [(SFAssemblyView *)self.view sizeThatFits:size];
}

@end
