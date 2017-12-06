//
//  NSObject+SFAddForm.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/9.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "NSObject+SFAddForm.h"
#import <objc/runtime.h>

@interface SFFormEventTarget : NSObject
@property (nonatomic,copy) SFFormEventBlock block;
- (void)invoke:(id)sender object:(NSObject*)object userInfo:(id)userInfo;
@end

@implementation SFFormEventTarget

- (void)invoke:(id)sender object:(NSObject *)object userInfo:(id)userInfo {
    if (self.block) {
        self.block(object, sender, userInfo);
    }
}

@end

@interface NSObject()
@property (nonatomic,strong) NSMutableDictionary *protocolEventHandlers;
@property (nonatomic,strong) NSMutableDictionary *controlEventHandlers;
@property (nonatomic,strong) NSMutableDictionary *customEventHandlers;
@end

@implementation NSObject (SFAddForm)

- (void)addProtocolEvent:(SEL)event block:(SFFormEventBlock)block {
    NSString *key = NSStringFromSelector(event);
    SFFormEventTarget *target = [SFFormEventTarget new];
    target.block = block;
    NSMutableArray *targets = self.protocolEventHandlers[key];
    if (targets == nil) {
        targets = [NSMutableArray new];
        self.protocolEventHandlers[key] = targets;
    }
    [targets addObject:target];
}

- (void)addControlEvent:(UIControlEvents)events block:(SFFormEventBlock)block {
    NSString *key = [@(events) stringValue];
    SFFormEventTarget *target = [SFFormEventTarget new];
    target.block = block;
    NSMutableArray *targets = self.controlEventHandlers[key];
    if (targets == nil) {
        targets = [NSMutableArray new];
        self.controlEventHandlers[key] = targets;
    }
    [targets addObject:target];
}

- (void)addCustomEvent:(NSString *)eventKey block:(SFFormEventBlock)block {
    NSString *key = eventKey;
    SFFormEventTarget *target = [SFFormEventTarget new];
    target.block = block;
    NSMutableArray *targets = self.customEventHandlers[key];
    if (targets == nil) {
        targets = [NSMutableArray new];
        self.customEventHandlers[key] = targets;
    }
    [targets addObject:target];
}

- (void)excuteProtocolEvent:(SEL)event sender:(id)sender userInfo:(id)userInfo {
    if (objc_getAssociatedObject(self, @selector(protocolEventHandlers))) {
        NSMutableArray *targets = self.protocolEventHandlers[NSStringFromSelector(event)];
        [targets enumerateObjectsUsingBlock:^(SFFormEventTarget *target, NSUInteger idx, BOOL * _Nonnull stop) {
            [target invoke:sender object:self userInfo:userInfo];
        }];
    }
}

- (void)excuteControlEvent:(UIControlEvents)events sender:(id)sender userInfo:(id)userInfo {
    if (objc_getAssociatedObject(self, @selector(controlEventHandlers))) {
        NSMutableArray *targets = self.controlEventHandlers[[@(events) stringValue]];
        [targets enumerateObjectsUsingBlock:^(SFFormEventTarget *target, NSUInteger idx, BOOL * _Nonnull stop) {
            [target invoke:sender object:self userInfo:userInfo];
        }];
    }
}

- (void)excuteCustomEvent:(NSString *)eventKey sender:(id)sender userInfo:(id)userInfo {
    if (objc_getAssociatedObject(self, @selector(customEventHandlers))) {
        NSMutableArray *targets = self.protocolEventHandlers[eventKey];
        [targets enumerateObjectsUsingBlock:^(SFFormEventTarget *target, NSUInteger idx, BOOL * _Nonnull stop) {
            [target invoke:sender object:self userInfo:userInfo];
        }];
    }
}

- (NSMutableDictionary *)protocolEventHandlers {
    return objc_getAssociatedObject(self, _cmd)?:({
        NSMutableDictionary *handlers = [NSMutableDictionary new];
        objc_setAssociatedObject(self, _cmd, handlers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        handlers;
    });
}

- (NSMutableDictionary *)controlEventHandlers {
    return objc_getAssociatedObject(self, _cmd)?:({
        NSMutableDictionary *handlers = [NSMutableDictionary new];
        objc_setAssociatedObject(self, _cmd, handlers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        handlers;
    });
}

- (NSMutableDictionary *)customEventHandlers {
    return objc_getAssociatedObject(self, _cmd)?:({
        NSMutableDictionary *handlers = [NSMutableDictionary new];
        objc_setAssociatedObject(self, _cmd, handlers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        handlers;
    });
}

- (NSArray *)controlEvents {
    return self.controlEventHandlers.allKeys.copy;
}

@end
