//
//  SFButtonComponent.h
//  SFAssembly
//
//  Created by YunSL on 2019/1/24.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFControlComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFButtonComponentStatus : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSAttributedString *attributedTitle;
@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIImage *backgroundImage;
@end

@interface SFButtonComponent : SFControlComponent
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,assign) NSUInteger numberOfLines;
@property (nonatomic,assign) NSTextAlignment textAlignment;
@property (nonatomic,assign) NSLineBreakMode lineBreakMode;
@property (nonatomic,assign) UIEdgeInsets titleEdgeInsets;
@property (nonatomic,assign) UIEdgeInsets imageEdgeInsets;
@property (nonatomic,assign) UIEdgeInsets contentInsets;
@property (nonatomic,strong) SFButtonComponentStatus *normalStatus;
@property (nonatomic,strong) SFButtonComponentStatus *disableStatus;
@property (nonatomic,strong) SFButtonComponentStatus *selectedStatus;
@property (nonatomic,strong) SFButtonComponentStatus *highlightedStatus;
@end

NS_ASSUME_NONNULL_END
