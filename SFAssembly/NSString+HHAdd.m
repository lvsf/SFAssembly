//
//  NSString+AddCalculate.m
//  HHForm
//
//  Created by YunSL on 16/8/4.
//  Copyright (c) 2016年 quanyou. All rights reserved.
//

#import "NSString+HHAdd.h"
#import <CoreText/CoreText.h>

static NSString *const HHTextTruncateToken = @"\u2026";

@implementation NSString (HHAdd)

- (CGSize)hh_textSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:maxSize
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:maxSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (NSArray<NSString *> *)hh_truncateTextLinesWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName:font}];
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedText);
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, NULL, CGRectMake(0, 0, maxSize.width, maxSize.height));
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, attributedText.length), pathRef, NULL);
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frameRef);
    
    NSMutableArray *lineTexts = [NSMutableArray new];
    [lines enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CTLineRef line = (__bridge CTLineRef)obj;
        CFRange cf_lineRange = CTLineGetStringRange(line);
        NSRange lineRange = NSMakeRange(cf_lineRange.location, cf_lineRange.length);
        NSString *lineText = [self substringWithRange:lineRange];
        if (lineText) {
            [lineTexts addObject:lineText];
        }
    }];
    return lineTexts;
}

- (NSString*)hh_truncateTextWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSMutableString *truncateText = [NSMutableString new];
    NSArray *textLines = [self hh_truncateTextLinesWithFont:font maxSize:maxSize];
    
    NSLog(@"--lines:%@",textLines);
    
    NSInteger __block textLength = 0;
    [textLines enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *lineText = text;
        textLength += text.length;
        //需要拼接省略号
        if (idx == textLines.count - 1 && textLength < self.length) {
            if (lineText.length > 0) {
                NSMutableString *m_lineText = [lineText mutableCopy];
                unichar lastCharacter = [m_lineText characterAtIndex:m_lineText.length - 1];
                if ([[NSCharacterSet whitespaceAndNewlineCharacterSet] characterIsMember:lastCharacter]) {
                    [m_lineText deleteCharactersInRange:NSMakeRange(lineText.length - 1, 1)];
                }
                CGFloat tokenWidth = [HHTextTruncateToken hh_textSizeWithFont:[UIFont fontWithName:font.fontName size:font.pointSize * 0.9] maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) lineBreakMode:NSLineBreakByTruncatingTail].width;
                CGFloat lastTextWidth = [m_lineText hh_textSizeWithFont:font maxSize:maxSize lineBreakMode:NSLineBreakByTruncatingTail].width;
                if (tokenWidth <= maxSize.width - lastTextWidth) {
                   //[m_lineText appendString:HHTextTruncateToken];
                } else {
                    NSString *lastCharacter = [m_lineText substringFromIndex:m_lineText.length - 1];
                    CGFloat lastCharacterWidth = [lastCharacter hh_textSizeWithFont:font maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) lineBreakMode:NSLineBreakByTruncatingTail].width;
                    NSInteger replaceTextLength = (lastCharacterWidth < tokenWidth && m_lineText.length >= 2)?2:1;
                    [m_lineText replaceCharactersInRange:NSMakeRange(m_lineText.length - replaceTextLength, replaceTextLength) withString:HHTextTruncateToken];
                }
                lineText = m_lineText.copy;
            }
        }
        if (truncateText.length > 0) {
            [truncateText appendString:@"\n"];
        }
        [truncateText appendString:lineText];
    }];
    return truncateText.copy;
}

+ (NSString *)hh_randomTextWithKind:(HHTextRandomKind)kind length:(NSUInteger)length {
    NSMutableString *letters = [NSMutableString new];
    if (kind & HHTextRandomKindNumber || kind == HHTextRandomKindAll) {
        [letters appendString:@"0123456789"];
    }
    if (kind & HHTextRandomKindLowercase || kind == HHTextRandomKindAll) {
        [letters appendString:@"abcdefghijklmnopqrstuvwxyz"];
    }
    if (kind & HHTextRandomKindUppercase || kind == HHTextRandomKindAll) {
        [letters appendString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    }
    BOOL shouldRandomKindChinseCharacter = ((kind & HHTextRandomKindChineseCharacter) || kind == HHTextRandomKindAll);
    NSMutableString *text = [NSMutableString new];
    for (NSUInteger i = 0; i < length; i++) {
        if (shouldRandomKindChinseCharacter && (letters.length == 0 || arc4random_uniform(2) == 0)) {
            [text appendString:[self hh_randomChineseCharacterTextWithLength:1]];
        } else {
            [text appendString:[NSString stringWithFormat:@"%C",[letters characterAtIndex:arc4random_uniform((UInt32)letters.length)]]];
        }
    }
    return text;
}

+ (NSString*)hh_randomChineseCharacterTextWithLength:(NSInteger)length {
    NSMutableString *text = [NSMutableString new];
    for (NSInteger i = 0; i < length; i++) {
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSInteger randomH = 0xA1 + arc4random()%(0xFE - 0xA1 + 1);
        NSInteger randomL = 0xB0 + arc4random()%(0xF7 - 0xB0 + 1);
        NSInteger number = (randomH<<8)+randomL;
        NSData *data = [NSData dataWithBytes:&number length:2];
        NSString *string = [[NSString alloc] initWithData:data encoding:gbkEncoding];
        if (string) {
            [text appendString:string];
        }
    }
    return text;
}

@end
