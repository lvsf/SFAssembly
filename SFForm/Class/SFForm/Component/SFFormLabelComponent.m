//
//  SFFormLabelComponent.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormLabelComponent.h"
#import "YYCategories/NSString+YYAdd.h"

@implementation SFFormLabelComponent

- (instancetype)init {
    if (self = [super init]) {
        self.font = [UIFont systemFontOfSize:14];
        self.numberOfLines = 0;
        self.textColor = [UIColor blackColor];
        self.attributedText = nil;
        self.text = nil;
        self.lineBreakMode = NSLineBreakByTruncatingTail;
        self.textAlignment = NSTextAlignmentLeft;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (UIView *)componentView {
    return [UILabel new];
}

- (BOOL)componentViewShouldDisplay {
    return self.text.length > 0;
}

- (void)componentViewWillAppear:(UILabel *)view {
    [super componentViewWillAppear:view];
    view.numberOfLines = self.numberOfLines;
    view.font = self.font;
    view.textColor = self.textColor;
    view.lineBreakMode = self.lineBreakMode;
    view.attributedText = self.attributedText;
    view.text = self.text;
    view.textAlignment = self.textAlignment;
}

- (CGSize)componentView:(UIView *)view boundSizeThatFits:(CGSize)size {
    CGSize textBoundSize = [self.text sizeForFont:self.font
                             size:size
                             mode:NSLineBreakByTruncatingTail];
    return CGSizeMake(MIN(size.width, textBoundSize.width), MIN(size.height, textBoundSize.height));
}

@end
