//
//  NSMutableArray+SFAssembly.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/4.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "NSMutableArray+SFAssembly.h"

@implementation NSMutableArray (SFAssembly)

- (NSMutableArray * _Nonnull (^)(id _Nonnull))safeAdd {
    return ^NSMutableArray *(id object){
        if (object) {
            [self addObject:object];
        }
        return self;
    };
}

@end
