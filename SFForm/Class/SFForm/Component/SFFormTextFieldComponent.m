//
//  SFFormTextFieldComponent.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormTextFieldComponent.h"
#import "UIView+SFAddComponent.h"

@interface SFFormTextFieldComponent()<UITextFieldDelegate>
@end

@implementation SFFormTextFieldComponent

#pragma mark - life
- (instancetype)init {
    if (self = [super init]) {
        self.borderStyle = UITextBorderStyleNone;
        self.text = nil;
        self.placeholder = nil;
        self.keyboardType = UIKeyboardTypeDefault;
        self.returnKeyType = UIReturnKeyDefault;
        self.clearButtonMode = UITextFieldViewModeNever;
        self.clearsOnBeginEditing = NO;
        self.enablesReturnKeyAutomatically = NO;
        self.secureTextEntry = NO;
        self.font = [UIFont systemFontOfSize:15];
        self.backgroundColor = [UIColor clearColor];
        self.textColor = [UIColor blackColor];
        self.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

#pragma mark - SFFormComponentProtocol
+ (UIView *)componentView {
    return [UITextField new];
}

- (void)componentViewDidLoad:(UITextField *)view {
    [super componentViewDidLoad:view];
}

- (void)componentViewWillAppear:(UITextField *)view {
    [super componentViewWillAppear:view];
    [view setText:self.text];
    [view setPlaceholder:self.placeholder];
    [view setBorderStyle:self.borderStyle];
    [view setKeyboardType:self.keyboardType];
    [view setReturnKeyType:self.returnKeyType];
    [view setClearButtonMode:self.clearButtonMode];
    [view setClearsOnBeginEditing:self.clearsOnBeginEditing];
    [view setEnablesReturnKeyAutomatically:self.enablesReturnKeyAutomatically];
    [view setSecureTextEntry:self.secureTextEntry];
    [view setFont:self.font];
    [view setTextColor:self.textColor];
    [view setTextAlignment:self.textAlignment];
    [view setDelegate:self];
}

- (CGSize)componentView:(UIView *)view boundSizeThatFits:(CGSize)size {
    return size;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = textField.text?:@"";
    text = [text stringByReplacingCharactersInRange:range withString:string];
    self.text = text;
    return YES;
}

@end
