//
//  SFFormButtonComponent.h
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/12.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormControlComponent.h"

@interface SFFormButtonComponentStatus : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSAttributedString *attributedTitle;
@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,strong) UIColor *shadowColor;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIImage *backgroundImage;
@end

@interface SFFormButtonComponent : SFFormControlComponent
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,assign) NSUInteger numberOfLines;
@property (nonatomic,assign) NSTextAlignment textAlignment;
@property (nonatomic,assign) NSLineBreakMode lineBreakMode;
@property (nonatomic,assign) UIEdgeInsets titleEdgeInsets;
@property (nonatomic,assign) UIEdgeInsets imageEdgeInsets;
@property (nonatomic,assign) UIEdgeInsets contentInsets;
@property (nonatomic,strong) SFFormButtonComponentStatus *normalStatus;
@property (nonatomic,strong) SFFormButtonComponentStatus *disableStatus;
@property (nonatomic,strong) SFFormButtonComponentStatus *selectedStatus;
@property (nonatomic,strong) SFFormButtonComponentStatus *highlightedStatus;
@end
