//
//  SFTextFieldComponent.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/5.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFTextFieldComponent.h"
#import "NSObject+SFEvent.h"

@interface SFTextFieldComponent()<UITextFieldDelegate>
@end

@implementation SFTextFieldComponent

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
        
        [self addActionForControlEvents:UIControlEventEditingChanged actionBlock:^(SFTextFieldComponent *actionObject, UITextField *sender, id userInfo) {
            actionObject.text = sender.text;
        }];
    }
    return self;
}

+ (UIView *)componentView {
    return [UITextField new];
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

- (CGSize)componentViewBoundSizeThatFits:(CGSize)size {
    return [self.view sizeThatFits:size];
}

@end
