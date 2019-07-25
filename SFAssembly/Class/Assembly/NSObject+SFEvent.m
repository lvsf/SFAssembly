//
//  NSObject+SFEvent.m
//  SFAssembly
//
//  Created by YunSL on 2017/11/9.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "NSObject+SFEvent.h"
#import <objc/runtime.h>

@interface SFEventActionTarget : NSObject
@property (nonatomic,copy) SFEventActionBlock block;
- (void)invoke:(id)sender object:(NSObject*)object userInfo:(id)userInfo;
@end

@implementation SFEventActionTarget

- (void)invoke:(id)sender object:(NSObject *)object userInfo:(id)userInfo {
    if (self.block) {
        self.block(object, sender, userInfo);
    }
}

@end

@interface NSObject()
@property (nonatomic,strong) NSMutableDictionary<NSString *, NSMutableArray *> *selectorEventActions;
@property (nonatomic,strong) NSMutableDictionary<NSString *, NSMutableArray *> *controlEventActions;
@property (nonatomic,strong) NSMutableDictionary<NSString *, NSMutableArray *> *customEventActions;
@property (nonatomic,strong) NSMutableArray<NSString *> *controlEvents;
@end

@implementation NSObject (SFEvent)

- (void)addActionForControlEvents:(UIControlEvents)controlEvents actionBlock:(SFEventActionBlock)actionBlock {
    NSString *key = [@(controlEvents) stringValue];
    if (key && actionBlock) {
        NSMutableArray *actionBlocks = self.controlEventActions[key];
        if (actionBlocks == nil) {
            actionBlocks = [NSMutableArray new];
            self.controlEventActions[key] = actionBlocks;
        }
        [actionBlocks addObject:actionBlock];
        if ([self.controlEvents containsObject:key] == NO) {
            [self.controlEvents addObject:key];
        }
    }
}

- (void)addActionForSelectorEvent:(SEL)selector actionBlock:(SFEventActionBlock)actionBlock {
    NSString *key = NSStringFromSelector(selector);
    if (key && actionBlock) {
        NSMutableArray *actionBlocks = self.selectorEventActions[key];
        if (actionBlocks == nil) {
            actionBlocks = [NSMutableArray new];
            self.selectorEventActions[key] = actionBlocks;
        }
        [actionBlocks addObject:actionBlock];
    }
}

- (void)addActionForCustomEvent:(NSString *)eventKey actionBlock:(SFEventActionBlock)actionBlock {
    NSString *key = eventKey;
    if (key && actionBlock) {
        NSMutableArray *actionBlocks = self.customEventActions[key];
        if (actionBlocks == nil) {
            actionBlocks = [NSMutableArray new];
            self.customEventActions[key] = actionBlocks;
        }
        [actionBlocks addObject:actionBlock];
    }
}

- (void)addActionForTableViewDidSelectedWithBlock:(void (^)(UITableView *, UITableViewCell *, NSIndexPath *))actionBlock {
    if (actionBlock) {
        [self addActionForSelectorEvent:@selector(tableView:didSelectRowAtIndexPath:) actionBlock:^(id actionObject, id sender, id userInfo) {
            UITableView *tableView = sender;
            UITableViewCell *cell = [userInfo objectForKey:@"UITableViewCell"];
            NSIndexPath *indexPath = [userInfo objectForKey:@"NSIndexPath"];
            actionBlock(tableView,cell,indexPath);
        }];
    }
}

- (void)addActionForCollectionViewDidSelectedWithBlock:(void (^)(UICollectionView *, UICollectionViewCell *, NSIndexPath *))actionBlock {
    if (actionBlock) {
        [self addActionForSelectorEvent:@selector(collectionView:didSelectItemAtIndexPath:) actionBlock:^(id actionObject, id sender, id userInfo) {
            UICollectionView *collectionView = sender;
            UICollectionViewCell *cell = [userInfo objectForKey:@"UICollectionViewCell"];
            NSIndexPath *indexPath = [userInfo objectForKey:@"NSIndexPath"];
            actionBlock(collectionView,cell,indexPath);
        }];
    }
}

- (void)sendActionsForControlEvents:(UIControlEvents)controlEvents sender:(id)sender userInfo:(id)userInfo {
    NSString *key = [@(controlEvents) stringValue];
    [self.controlEventActions[key] enumerateObjectsUsingBlock:^(SFEventActionBlock obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj(self,sender,userInfo);
    }];
}

- (void)sendActionsForSelectorEvent:(SEL)selector sender:(id)sender userInfo:(id)userInfo {
    NSString *key = NSStringFromSelector(selector);
    [self.selectorEventActions[key] enumerateObjectsUsingBlock:^(SFEventActionBlock obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj(self,sender,userInfo);
    }];
}

- (void)sendActionsForCustomEvent:(NSString *)eventKey sender:(id)sender userInfo:(id)userInfo {
    NSString *key = eventKey;
    [self.customEventActions[key] enumerateObjectsUsingBlock:^(SFEventActionBlock obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj(self,sender,userInfo);
    }];
}

- (NSArray<NSString *> *)action_controlEvents {
    return self.controlEvents;
}

- (NSMutableArray<NSString *> *)controlEvents {
    return objc_getAssociatedObject(self, _cmd)?:({
        NSMutableArray *controlEvents = [NSMutableArray new];
        objc_setAssociatedObject(self, _cmd, controlEvents, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        controlEvents;
    });
}

- (NSMutableDictionary<NSString *,NSMutableArray *> *)selectorEventActions {
    return objc_getAssociatedObject(self, _cmd)?:({
        NSMutableDictionary *actions = [NSMutableDictionary new];
        objc_setAssociatedObject(self, _cmd, actions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        actions;
    });
}

- (NSMutableDictionary<NSString *,NSMutableArray *> *)controlEventActions {
    return objc_getAssociatedObject(self, _cmd)?:({
        NSMutableDictionary *actions = [NSMutableDictionary new];
        objc_setAssociatedObject(self, _cmd, actions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        actions;
    });
}

- (NSMutableDictionary<NSString *,NSMutableArray *> *)customEventActions {
    return objc_getAssociatedObject(self, _cmd)?:({
        NSMutableDictionary *actions = [NSMutableDictionary new];
        objc_setAssociatedObject(self, _cmd, actions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        actions;
    });
}

@end
