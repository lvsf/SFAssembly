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
@end

NS_ASSUME_NONNULL_END
