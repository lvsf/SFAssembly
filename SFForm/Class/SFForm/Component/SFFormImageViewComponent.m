//
//  SFFormImageViewComponent.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormImageViewComponent.h"
#import "UIImageView+WebCache.h"

@implementation SFFormImageViewComponent

- (instancetype)init {
    if (self = [super init]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

+ (UIView *)componentView {
    return [UIImageView new];
}

- (void)componentViewWillAppear:(UIImageView *)view {
    [super componentViewWillAppear:view];
    [view setImage:self.image];
    if (self.imageURL.length > 0) {
        NSURL *URL = [NSURL URLWithString:self.imageURL];
        if (URL) {
            [view sd_setImageWithURL:URL placeholderImage:self.image];
        }
    }
}

- (BOOL)componentViewShouldDisplay {
    return (self.image != nil || self.imageURL.length > 0);
}

@end
