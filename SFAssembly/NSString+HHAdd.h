//
//  NSString+AddCalculate.h
//  HHForm
//
//  Created by YunSL on 16/8/4.
//  Copyright (c) 2016年 quanyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 随机文本类型

 - HHTextRandomKindNumber:          数字
 - HHTextRandomKindLowercase:       小写字母
 - HHTextRandomKindUppercase:       大写字母
 - HHTextRandomKindChineseCharacter: 汉字
 */
typedef NS_ENUM(NSInteger,HHTextRandomKind){
    HHTextRandomKindNumber           = 1 << 0,
    HHTextRandomKindLowercase        = 1 << 1,
    HHTextRandomKindUppercase        = 1 << 2,
    HHTextRandomKindChineseCharacter = 1 << 3,
    HHTextRandomKindAll              = 1 << 4
};

@interface NSString (HHAdd)

/**
 随机指定长度的文本

 @param kind   文本类型
 @param length 文本长度
 @return NSString
 */
+ (NSString*)hh_randomTextWithKind:(HHTextRandomKind)kind
                            length:(NSUInteger)length;

- (NSString*)hh_truncateTextWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

- (CGSize)hh_textSizeWithFont:(UIFont *)font
                      maxSize:(CGSize)maxSize
                lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (NSArray<NSString*>*)hh_truncateTextLinesWithFont:(UIFont*)font
                                            maxSize:(CGSize)maxSize;
@end
