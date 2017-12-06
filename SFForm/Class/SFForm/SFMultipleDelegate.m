//
//  SFMultipleDelegate.m
//  SFFormView
//
//  Created by YunSL on 17/10/20.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFMultipleDelegate.h"

@implementation SFMultipleDelegate
@synthesize delegates = _delegates;

+ (instancetype)multipleDelegateWithOriginal:(id)delegate {
    SFMultipleDelegate *multipleDelegate = [self new];
    multipleDelegate.originalDelegate = delegate;
    return multipleDelegate;
}

- (void)addDelegate:(id)delegate {
    if (delegate && [self.delegates.allObjects indexOfObject:delegate] == NSNotFound) {
        [self.delegates addPointer:(__bridge void * _Nullable)(delegate)];
    }
}

- (void)removeDelegate:(id)delegate {
    NSInteger index = [self.delegates.allObjects indexOfObject:delegate];
    if (index != NSNotFound) {
        [self.delegates removePointerAtIndex:index];
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([self.originalDelegate respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:self.originalDelegate];
    }
    else {
        for (NSObject *delegate in self.delegates.allObjects) {
            if ([delegate respondsToSelector:anInvocation.selector]) {
                [anInvocation invokeWithTarget:delegate];
            }
        }
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    if ([self.originalDelegate respondsToSelector:aSelector]) {
        return YES;
    }
    BOOL responds = NO;
    for (NSObject *delegate in self.delegates.allObjects) {
        if ([delegate respondsToSelector:aSelector]) {
            responds = YES;
            break;
        }
    }
    return responds;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = nil;
    if ([self.originalDelegate respondsToSelector:aSelector]) {
        signature = [(NSObject*)self.originalDelegate methodSignatureForSelector:aSelector];
    }
    if (signature == nil) {
        for (NSObject *delegate in self.delegates.allObjects) {
            if ([delegate respondsToSelector:aSelector]) {
                signature = [delegate methodSignatureForSelector:aSelector];
                if (signature) {
                    break;
                }
            }
        }
    }
    return signature;
}

- (NSPointerArray *)delegates {
    return _delegates?:({
        _delegates = [NSPointerArray weakObjectsPointerArray];
        _delegates;
    });
}

@end
