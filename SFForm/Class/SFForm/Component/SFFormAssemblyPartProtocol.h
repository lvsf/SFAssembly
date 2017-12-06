//
//  SFFormAssemblyPartProtocol.h
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//  角色

#import "SFFormViewComponent.h"

@protocol SFFormAssemblyPartProtocol <NSObject>
@property (nonatomic,strong) SFFormViewComponent *containerComponent;
@property (nonatomic,assign) UIEdgeInsets containerInsets;
@end
