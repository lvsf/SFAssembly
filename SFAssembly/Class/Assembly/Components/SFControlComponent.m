//
//  SFControlComponent.m
//  SFAssembly
//
//  Created by YunSL on 2019/1/24.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFControlComponent.h"
#import "NSObject+SFEvent.h"
#import "UIView+SFAssembly.h"
#import <objc/runtime.h>

@interface SFControlComponentBlockTarget : NSObject

@property (nonatomic,copy) void (^block)(id sender);
@property (nonatomic,assign) UIControlEvents events;

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events;
- (void)invoke:(id)sender;

@end

@implementation SFControlComponentBlockTarget

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events {
    self = [super init];
    if (self) {
        _block = [block copy];
        _events = events;
    }
    return self;
}

- (void)invoke:(id)sender {
    if (_block) _block(sender);
}

@end

@implementation UIControl (SFControlComponent)

- (void)control_setBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id))block {
    NSString *key = [@(controlEvents) stringValue];
    if (key && block) {
       NSMutableArray *targets = [[self component_controlEventsTargets] objectForKey:key];
        if (targets.count > 0) {
            [targets removeAllObjects];
        }
        [self control_addBlockForControlEvents:controlEvents block:block];
    }
}

- (void)control_addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id))block {
    NSString *key = [@(controlEvents) stringValue];
    if (key && block) {
        NSMutableArray *targets = [[self component_controlEventsTargets] objectForKey:key];
        if (targets == nil) {
            targets = [NSMutableArray new];
            [self component_controlEventsTargets][key] = targets;
        }
        SFControlComponentBlockTarget *target = [[SFControlComponentBlockTarget alloc] initWithBlock:block events:controlEvents];
        [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
        [targets addObject:target];
    }
}

- (BOOL)control_respondToControlEvents:(UIControlEvents)controlEvents {
    return [[self component_controlEventsTargets].allKeys containsObject:[@(controlEvents) stringValue]];
}

- (NSMutableDictionary<NSString *, NSMutableArray *> *)component_controlEventsTargets {
    return objc_getAssociatedObject(self, _cmd)?:({
        NSMutableDictionary *targets = [NSMutableDictionary new];
        objc_setAssociatedObject(self, _cmd, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        targets;
    });
}

@end

@implementation SFControlComponent

- (instancetype)init {
    if (self = [super init]) {
        self.enabled = YES;
        self.selected = NO;
        self.highlighted = NO;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return self;
}

- (void)componentViewWillAppear:(UIControl *)view {
    [super componentViewWillAppear:view];
    [view setEnabled:self.enabled];
    [view setSelected:self.selected];
    [view setHighlighted:self.highlighted];
    [view setContentHorizontalAlignment:self.contentHorizontalAlignment];
    [view setContentVerticalAlignment:self.contentVerticalAlignment];
    [[self action_controlEvents] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIControlEvents events = [obj integerValue];
        if ([view control_respondToControlEvents:events] == NO) {
            [view control_setBlockForControlEvents:events block:^(UIControl *sender) {
                [(SFControlComponent *)sender.component sendActionsForControlEvents:events sender:sender userInfo:nil];
            }];
        }
    }];
}

@end
