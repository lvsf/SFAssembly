//
//  SFFormTableSection.h
//  SFFormView
//
//  Created by YunSL on 17/10/19.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFFormSection.h"
#import "SFFormTableSectionHeaderFooter.h"

@interface SFFormTableSection : SFFormSection
@property (nonatomic,strong,readonly) SFFormTableSectionHeaderFooter *header;
@property (nonatomic,strong,readonly) SFFormTableSectionHeaderFooter *footer;
@end
