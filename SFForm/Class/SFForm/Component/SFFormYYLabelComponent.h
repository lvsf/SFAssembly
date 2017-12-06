//
//  SFFormYYLabelComponent.h
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/12.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormViewComponent.h"

@interface SFFormYYLabelComponent : SFFormViewComponent
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSAttributedString *attributedText;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,assign) NSUInteger numberOfLines;
@property (nonatomic,assign) NSTextAlignment textAlignment;
@property (nonatomic,assign) NSLineBreakMode lineBreakMode;
@end
