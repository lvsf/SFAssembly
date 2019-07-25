//
//  SFImageViewComponent.m
//  SFAssembly
//
//  Created by YunSL on 2019/1/22.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFImageViewComponent.h"
#import "SDWebImage.h"

@implementation SFImageViewComponent

- (instancetype)init {
    if (self = [super init]) {
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.clipsToBounds = YES;
    }
    return self;
}

+ (nonnull UIView *)componentView {
    return [UIImageView new];
}

- (CGSize)componentViewBoundSizeThatFits:(CGSize)size {
    CGFloat width = size.width;
    CGFloat height = size.height;
    if (self.image) {
        CGFloat wRatio = 1;
        CGFloat hRatio = 1;
        if (width < CGFLOAT_MAX) {
            wRatio = self.image.size.width/size.width;
        }
        if (height < CGFLOAT_MAX) {
            hRatio = self.image.size.height/size.height;
        }
        CGFloat ratio = MAX(wRatio, hRatio);
        width = self.image.size.width / ratio;
        height = self.image.size.height / ratio;
    }
    return CGSizeMake(width, height);
}

- (void)componentViewDidLoad:(nonnull UIView *)view {
    [super componentViewDidLoad:view];
}

- (void)componentViewWillAppear:(nonnull UIImageView *)view {
    [super componentViewWillAppear:view];
    [view setImage:self.image];
    if (self.imageURL.length > 0) {
        NSURL *URL = [NSURL URLWithString:self.imageURL];
        if (URL) {
            //下载图片
            [view sd_setImageWithURL:URL placeholderImage:self.image];
        }
    }
}

- (BOOL)componentViewShouldDisplay {
    return (self.image || self.imageURL.length > 0);
}

@end
