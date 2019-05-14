//
//  SFLabelComponent.m
//  SFAssembly
//
//  Created by YunSL on 2019/1/21.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFLabelComponent.h"

@interface SFLabelComponent()
@property (nonatomic,copy) NSAttributedString *p_attributedText;
@property (nonatomic,strong) NSMutableDictionary *attributes;
@property (nonatomic,strong) NSMutableParagraphStyle *paragraphStyle;
@property (nonatomic,assign) BOOL attributedTextNeedUpdate;
@end

@implementation SFLabelComponent

- (instancetype)init {
    if (self = [super init]) {
        self.font = [UIFont systemFontOfSize:14];
        self.numberOfLines = 0;
        self.textColor = [UIColor blackColor];
        self.attributedText = nil;
        self.text = nil;
        self.lineBreakMode = NSLineBreakByWordWrapping;
        self.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

+ (UIView *)componentView {
    return [UILabel new];
}

- (BOOL)componentViewShouldDisplay {
    return self.text.length > 0 || self.attributedText.length > 0;
}

- (void)componentViewWillAppear:(UILabel *)view {
    [super componentViewWillAppear:view];
    if ([view isKindOfClass:[UILabel class]]) {
        view.numberOfLines = self.numberOfLines;
        view.font = self.font;
        view.textColor = self.textColor;
        view.lineBreakMode = self.lineBreakMode;
        view.textAlignment = self.textAlignment;
        view.attributedText = self.attributedText;
    }
}

- (CGSize)componentViewBoundSizeThatFits:(CGSize)size {
    CGSize textBoundSize = CGSizeZero;
    NSAttributedString *attributedText = self.attributedText;
    if (attributedText.length > 0) {
        textBoundSize = [attributedText boundingRectWithSize:size
                                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                     context:nil].size;
    }
    return textBoundSize;
}

- (void)setText:(NSString *)text {
    _text = text;
    _attributedTextNeedUpdate = YES;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.attributes[NSFontAttributeName] = font;
    _attributedTextNeedUpdate = YES;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.attributes[NSForegroundColorAttributeName] = textColor;
    _attributedTextNeedUpdate = YES;
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
    _lineBreakMode = lineBreakMode;
    self.paragraphStyle.lineBreakMode = _lineBreakMode;
    _attributedTextNeedUpdate = YES;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    self.paragraphStyle.alignment = textAlignment;
    _attributedTextNeedUpdate = YES;
}

- (NSAttributedString *)attributedText {
    if (_attributedText) {
        return _attributedText;
    }
    if (_text) {
        if (_p_attributedText == nil || _attributedTextNeedUpdate) {
            _attributedTextNeedUpdate = NO;
            _p_attributedText = [[NSMutableAttributedString alloc] initWithString:_text attributes:_attributes];
        }
    }
    else {
        _p_attributedText = nil;
    }
    return _p_attributedText;
}

- (NSMutableParagraphStyle *)paragraphStyle {
    return _paragraphStyle?:({
        _paragraphStyle = [NSMutableParagraphStyle new];
        _paragraphStyle;
    });
}

- (NSMutableDictionary *)attributes {
    return _attributes?:({
        _attributes = [NSMutableDictionary new];
        _attributes[NSParagraphStyleAttributeName] = self.paragraphStyle;
        _attributes;
    });
}

- (SFLabelComponent * _Nonnull (^)(NSString * _Nullable))sText {
    return ^SFLabelComponent *(NSString *text){
        self.text = text;
        return self;
    };
}

- (SFLabelComponent * _Nonnull (^)(NSAttributedString * _Nullable))sAttributedText {
    return ^SFLabelComponent *(NSAttributedString *attributedText){
        self.attributedText = attributedText;
        return self;
    };
}

- (SFLabelComponent *(^)(UIColor *))sTextColor {
    return ^SFLabelComponent *(UIColor *textColor){
        self.textColor = textColor;
        return self;
    };
}

- (SFLabelComponent *(^)(UIFont *))sFont {
    return ^SFLabelComponent *(UIFont *font){
        self.font = font;
        return self;
    };
}

- (SFLabelComponent *(^)(NSUInteger))sNumberOfLines {
    return ^SFLabelComponent *(NSUInteger numberOfLines){
        self.numberOfLines = numberOfLines;
        return self;
    };
}
- (SFLabelComponent *(^)(NSTextAlignment))sTextAlignment {
    return ^SFLabelComponent *(NSTextAlignment textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
}

- (SFLabelComponent *(^)(NSLineBreakMode))sLineBreakMode {
    return ^SFLabelComponent *(NSLineBreakMode lineBreakMode){
        self.lineBreakMode = lineBreakMode;
        return self;
    };
}

@end
