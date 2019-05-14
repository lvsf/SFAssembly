//
//  SFTableAssemblySectionHeaderFooter.h
//  SFAssembly
//
//  Created by YunSL on 2019/5/13.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFTableSectionHeaderFooter.h"
#import "SFFormSectionHeaderFooterLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFTableAssemblySectionHeaderFooter : SFTableSectionHeaderFooter
@property (nonatomic,strong) SFAssemblyLayout *layout;
@property (nonatomic,strong,readonly) SFFormSectionHeaderFooterLayout *easyLayout;
@end

NS_ASSUME_NONNULL_END
