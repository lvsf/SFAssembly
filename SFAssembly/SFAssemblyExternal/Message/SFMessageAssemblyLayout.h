//
//  SFMessageAssemblyLayout.h
//  SFAssembly
//
//  Created by YunSL on 2019/1/21.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFAssemblyLayout.h"
#import "SFExternalAssemblyPlace.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFMessageAssemblyLayout : SFAssemblyLayout
@property (nonatomic,strong) SFExternalAssemblyPlace *avatar;
@property (nonatomic,strong) SFExternalAssemblyPlace *name;
@property (nonatomic,strong) SFExternalAssemblyPlace *content;
@property (nonatomic,strong) SFExternalAssemblyPlace *createDate;
@property (nonatomic,strong) SFExternalAssemblyPlace *title;
@property (nonatomic,strong) SFExternalAssemblyPlace *detailText;
@property (nonatomic,strong) SFExternalAssemblyPlace *address;
@property (nonatomic,strong) SFExternalAssemblyPlace *follow;
@property (nonatomic,strong) SFExternalAssemblyPlace *voice;
@property (nonatomic,strong) SFExternalAssemblyPlace *messageIdentity;
@end

NS_ASSUME_NONNULL_END
