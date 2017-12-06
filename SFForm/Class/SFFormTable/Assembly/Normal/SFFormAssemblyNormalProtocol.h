//
//  SFFormAssemblyBaseProtocol.h
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//  

#import "SFFormAssemblyPartProtocol.h"
#import "SFFormViewComponent.h"

@protocol SFFormAssemblyNormalProtocol <SFFormAssemblyPartProtocol>
@property (nonatomic,strong) SFFormViewComponent *headerComponent;
@property (nonatomic,strong) SFFormViewComponent *subHeaderComponent;
@property (nonatomic,strong) SFFormViewComponent *contentComponent;
@property (nonatomic,strong) SFFormViewComponent *subFooterComponent;
@property (nonatomic,strong) SFFormViewComponent *footerComponent;
@property (nonatomic,assign) CGFloat supportSpacing;
@property (nonatomic,assign) CGFloat contentSpacing;
@end
