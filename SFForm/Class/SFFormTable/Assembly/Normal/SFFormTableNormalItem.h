//
//  SFFormTableNormalItem.h
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormTableAssemblyItem.h"
#import "SFFormAssemblyNormalProtocol.h"
#import "SFFormLabelComponent.h"
#import "SFFormYYLabelComponent.h"
#import "SFFormImageViewComponent.h"
#import "SFFormTextFieldComponent.h"
#import "SFFormButtonComponent.h"

@interface SFFormTableNormalItem : SFFormTableAssemblyItem<SFFormAssemblyNormalProtocol>

@property (nonatomic,strong) SFFormImageViewComponent *iconImageView;
@property (nonatomic,strong) SFFormLabelComponent *titleLabel;
@property (nonatomic,strong) SFFormLabelComponent *detailLabel;

@property (nonatomic,strong) SFFormLabelComponent *contentLabel;
@property (nonatomic,strong) SFFormYYLabelComponent *contentYYLabel;
@property (nonatomic,strong) SFFormImageViewComponent *contentImageView;
@property (nonatomic,strong) SFFormTextFieldComponent *contentTextField;
@property (nonatomic,strong) SFFormButtonComponent *contentButton;

+ (instancetype)labelItemWithIcon:(UIImage *)image
                            title:(NSString *)title
                          content:(NSString *)content
                         selected:(SFFormEventBlock)selectedBlock;
@end

