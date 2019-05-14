//
//  SFFormTableSection.h
//  SFFormView
//
//  Created by YunSL on 17/10/19.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFFormSection.h"
#import "SFTableSectionHeaderFooter.h"
#import "SFTableAssemblySectionHeaderFooter.h"

@interface SFTableSection : SFFormSection
@property (nonatomic,strong,readonly) SFTableSectionHeaderFooter *header;
@property (nonatomic,strong,readonly) SFTableSectionHeaderFooter *footer;
@property (nonatomic,strong,readonly) SFTableAssemblySectionHeaderFooter *assemblyHeader;
@property (nonatomic,strong,readonly) SFTableAssemblySectionHeaderFooter *assemblyFooter;
- (SFTableSectionHeaderFooter *)sectionHeader;
- (SFTableSectionHeaderFooter *)sectionFooter;
@end
