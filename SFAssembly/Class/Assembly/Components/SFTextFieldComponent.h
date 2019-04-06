//
//  SFTextFieldComponent.h
//  SFAssembly
//
//  Created by YunSL on 2019/4/5.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFControlComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFTextFieldComponent : SFControlComponent
@property (nonatomic,copy,nullable) NSString *text;
@property (nonatomic,assign) NSTextAlignment textAlignment;
@property (nonatomic,copy,nullable) NSString *placeholder;
@property (nonatomic,assign) UITextBorderStyle borderStyle;
@property (nonatomic,assign) UIKeyboardType keyboardType;
@property (nonatomic,assign) UIReturnKeyType returnKeyType;
@property (nonatomic,assign) UITextFieldViewMode clearButtonMode;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,assign) BOOL clearsOnBeginEditing;
@property (nonatomic,assign) BOOL enablesReturnKeyAutomatically;
@property (nonatomic,assign) BOOL secureTextEntry;
@end

NS_ASSUME_NONNULL_END
