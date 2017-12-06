//
//  SFMultipleDelegate.h
//  SFFormView
//
//  Created by YunSL on 17/10/20.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFMultipleDelegate : NSObject
@property (nonatomic,copy,readonly) NSPointerArray *delegates;
@property (nonatomic,weak) id originalDelegate;
+ (instancetype)multipleDelegateWithOriginal:(id)delegate;
- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;
@end
