//
//  SFMultipleDelegate.m
//  SFFormView
//
//  Created by YunSL on 17/10/20.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFMultipleProxy.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"

@implementation SFMultipleProxy
@synthesize proxies = _proxies;

+ (instancetype)multipleProxyWithOriginalProxy:(id)originalProxy {
    SFMultipleProxy *proxy = [self new];
    proxy.originalProxy = originalProxy;
    return proxy;
}

- (void)addProxy:(id)proxy {
    if (proxy && [self.proxies.allObjects indexOfObject:proxy] == NSNotFound) {
        [self.proxies addPointer:(__bridge void * _Nullable)(proxy)];
    }
}

- (void)removeProxy:(id)proxy {
    NSInteger index = [self.proxies.allObjects indexOfObject:proxy];
    if (index != NSNotFound) {
        [self.proxies removePointerAtIndex:index];
    }
}

- (void)removeAllProxies {
    NSInteger count = self.proxies.count;
    for (NSInteger i = 0; i < count; i++) {
        [self.proxies removePointerAtIndex:i];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    if ([self.originalProxy respondsToSelector:aSelector]) {
        return YES;
    }
    BOOL responds = NO;
    for (NSObject *proxy in self.proxies.allObjects) {
        if ([proxy respondsToSelector:aSelector]) {
            responds = YES;
            break;
        }
    }
    return responds;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    __block id forwardingTarget = [super forwardingTargetForSelector:aSelector];
    if ([self.originalProxy respondsToSelector:aSelector]) {
        forwardingTarget = self.originalProxy;
    }
    else {
        [self.proxies.allObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj respondsToSelector:aSelector]) {
                forwardingTarget = obj;
                *stop = YES;
            }
        }];
    }
    return forwardingTarget;
}

- (NSPointerArray *)proxies {
    return _proxies?:({
        _proxies = [NSPointerArray weakObjectsPointerArray];
        _proxies;
    });
}

@end

#pragma clang diagnostic pop
