//
//  SFFormTextFieldComponent.h
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormControlComponent.h"

@interface SFFormTextFieldComponent : SFFormControlComponent
@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign) NSTextAlignment textAlignment;
@property (nonatomic,copy) NSString *placeholder;
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
