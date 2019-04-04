//
//  NSMutableArray+SFAssembly.h
//  SFAssembly
//
//  Created by YunSL on 2019/4/4.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (SFAssembly)
- (NSMutableArray *(^)(id object))safeAdd;
@end

NS_ASSUME_NONNULL_END
