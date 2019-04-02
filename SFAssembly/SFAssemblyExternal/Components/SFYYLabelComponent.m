//
//  SFYYLabelComponent.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/2.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFYYLabelComponent.h"
#import <YYLabel.h>

@implementation SFYYLabelComponent

+ (UIView *)componentView {
    return [[YYLabel alloc] initWithFrame:CGRectZero];
}

- (void)componentViewDidLoad:(YYLabel *)view {
    [super componentViewDidLoad:view];
    if ([view isKindOfClass:[YYLabel class]]) {
        view.displaysAsynchronously = YES;
    }
}

- (void)componentViewWillAppear:(YYLabel *)view {
    [super componentViewWillAppear:view];
    if ([view isKindOfClass:[YYLabel class]]) {
        view.numberOfLines = self.numberOfLines;
        view.font = self.font;
        view.textColor = self.textColor;
        view.lineBreakMode = self.lineBreakMode;
        view.textAlignment = self.textAlignment;
        view.attributedText = self.attributedText;
    }
}

@end
