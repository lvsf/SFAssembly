//
//  SFLabelComponent.h
//  SFAssembly
//
//  Created by YunSL on 2019/1/21.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFViewComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFLabelComponent : SFViewComponent
@property (nullable,nonatomic,copy) NSString *text;
@property (nullable,nonatomic,copy) NSAttributedString *attributedText;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,assign) NSUInteger numberOfLines;
@property (nonatomic,assign) NSTextAlignment textAlignment;
@property (nonatomic,assign) NSLineBreakMode lineBreakMode;
- (SFLabelComponent *(^)( NSString *_Nullable))sText;
- (SFLabelComponent *(^)(NSAttributedString *_Nullable))sAttributedText;
- (SFLabelComponent *(^)(UIColor *))sTextColor;
- (SFLabelComponent *(^)(UIFont *))sFont;
- (SFLabelComponent *(^)(NSUInteger))sNumberOfLines;
- (SFLabelComponent *(^)(NSTextAlignment))sTextAlignment;
- (SFLabelComponent *(^)(NSLineBreakMode))sLineBreakMode;
@end

NS_ASSUME_NONNULL_END
