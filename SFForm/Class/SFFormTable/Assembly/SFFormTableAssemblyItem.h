//
//  SFFormTableAssemblyItem.h
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormTableItem.h"
#import "SFFormAssemblyLayoutProtocol.h"

@interface SFFormTableAssemblyItem : SFFormTableItem<SFFormAssemblyPartProtocol> {
    id<SFFormAssemblyLayoutProtocol> _layout;
}
@property (nonatomic,assign) BOOL needLayout;
@property (nonatomic,strong) id <SFFormAssemblyLayoutProtocol>layout;
- (void)reload;
- (void)setNeedLayout;
- (NSArray<SFFormViewComponent*>*)allComponents;
@end
