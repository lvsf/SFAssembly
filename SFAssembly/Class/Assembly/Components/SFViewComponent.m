//
//  SFViewComponent.m
//  SFAssembly
//
//  Created by YunSL on 2019/1/21.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFViewComponent.h"

@implementation SFViewComponent
@synthesize view = _view;

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.hidden = NO;
        self.clipsToBounds = NO;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)update {
    if (_view && [self respondsToSelector:@selector(componentViewWillAppear:)]) {
        [self componentViewWillAppear:_view];
    }
}

#pragma mark - SFAssemblyComponentProtocol
+ (UIView *)componentView {
    return [UIView new];
}

- (BOOL)componentViewShouldDisplay {
    return YES;
}

- (void)componentViewDidLoad:(UIView *)view {
}

- (void)componentViewWillAppear:(UIView *)view {
    view.backgroundColor = self.backgroundColor;
    view.contentMode = self.contentMode;
    view.hidden = self.hidden;
    view.clipsToBounds = self.clipsToBounds;
    view.userInteractionEnabled = self.userInteractionEnabled;
}

- (CGSize)componentViewBoundSizeThatFits:(CGSize)size {
    return size;
}

@end
