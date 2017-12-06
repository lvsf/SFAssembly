//
//  SFFormYYLabelComponent.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/12.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormYYLabelComponent.h"
#import <YYText.h>

@interface SFFormYYLabelComponent()
@property (nonatomic,strong) NSMutableAttributedString *praviteAttributedText;
@end

@implementation SFFormYYLabelComponent

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
    return [[YYLabel alloc] initWithFrame:CGRectZero];
}

- (BOOL)componentViewShouldDisplay {
    return self.text.length > 0 || self.attributedText.length > 0;
}

- (void)componentViewWillAppear:(YYLabel *)view {
    [super componentViewWillAppear:view];
    view.numberOfLines = self.numberOfLines;
    view.attributedText = self.praviteAttributedText.copy;
}

- (CGSize)componentView:(UIView *)view boundSizeThatFits:(CGSize)size {
    CGSize textBoundSize = CGSizeZero;
    if (self.layoutMode == SFFormComponentLayouModeFit) {
        textBoundSize = [YYTextLayout layoutWithContainerSize:size text:self.praviteAttributedText.copy].textBoundingSize;
    }
    else {
        textBoundSize = size;
    }
    return CGSizeMake(MIN(size.width, textBoundSize.width), MIN(size.height, textBoundSize.height));
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedText = attributedText;
    [self setPraviteAttributedText:[attributedText mutableCopy]];
}

- (void)setText:(NSString *)text {
    _text = text;
    [self setPraviteAttributedText:({
        NSMutableAttributedString *attributedText = [NSMutableAttributedString new];
        if (text) {
            [attributedText yy_appendString:text];
        }
        attributedText;
    })];
    [self.praviteAttributedText setYy_font:self.font];
    [self.praviteAttributedText setYy_color:self.textColor];
    [self.praviteAttributedText setYy_lineBreakMode:self.lineBreakMode];
    [self.praviteAttributedText setYy_alignment:self.textAlignment];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    [self.praviteAttributedText setYy_font:font];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self.praviteAttributedText setYy_color:textColor];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    [self.praviteAttributedText setYy_alignment:textAlignment];
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
    _lineBreakMode = lineBreakMode;
    [self.praviteAttributedText setYy_lineBreakMode:lineBreakMode];
}

- (NSMutableAttributedString *)praviteAttributedText {
    return _praviteAttributedText?:({
        _praviteAttributedText = [NSMutableAttributedString new];
        _praviteAttributedText;
    });
}

@end
