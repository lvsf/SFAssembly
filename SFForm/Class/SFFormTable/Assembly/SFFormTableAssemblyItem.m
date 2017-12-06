//
//  SFFormTableAssemblyItem.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormTableAssemblyItem.h"

@implementation SFFormTableAssemblyItem
@synthesize containerComponent = _containerComponent;
@synthesize containerInsets = _containerInsets;

- (instancetype)init {
    if (self = [super init]) {
        self.className = @"SFFormTableAssemblyCell";
        self.needLayout = YES;
        self.enforceFrameLayout = YES;
    }
    return self;
}

- (void)reload {
    [self.allComponents enumerateObjectsUsingBlock:^(SFFormViewComponent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(componentViewWillAppear:)]) {
            [obj componentViewWillAppear:obj.componentView];
        }
    }];
}

- (void)setNeedLayout {
    self.needLayout = YES;
}

- (CGFloat)height {
    return [self.layout boundSize].height;
}

- (NSArray<SFFormViewComponent *> *)allComponents {
    return @[];
}

@end
