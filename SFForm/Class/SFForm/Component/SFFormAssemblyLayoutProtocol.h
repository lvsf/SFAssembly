//
//  SFFormAssemblyLayoutProtocol.h
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//  布局

#import "SFFormAssemblyPartProtocol.h"

@protocol SFFormAssemblyLayoutProtocol <NSObject>
@property (nonatomic,assign,readonly) CGSize boundSize;
- (CGSize)layoutWithAssemblyPart:(id<SFFormAssemblyPartProtocol>)assemblyPart
                       maxSize:(CGSize)size;
@end
