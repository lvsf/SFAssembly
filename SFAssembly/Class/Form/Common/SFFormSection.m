//
//  SFFormSection.m
//  SFFormView
//
//  Created by YunSL on 17/10/20.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFFormSection.h"

@interface SFFormSection()
@property (nonatomic,strong) NSMutableArray<SFFormItem *> *formItems;
@end

@implementation SFFormSection

#pragma mark - public
- (void)addItem:(SFFormItem *)item {
    if (![self.items containsObject:item]) {
        [self.formItems addObject:item];
    }
}

- (void)addItem:(SFFormItem *)item forKey:(NSString *)key {
    [item setKey:key];
    [self addItem:item];
}

- (void)addItems:(NSArray<SFFormItem *> *)items {
    [items enumerateObjectsUsingBlock:^(SFFormItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addItem:obj];
    }];
}

- (void)insertItem:(SFFormItem *)item atIndex:(NSInteger)index {
    [self.formItems insertObject:item atIndex:index];
}

- (void)insertItems:(NSArray<SFFormItem *> *)items atIndex:(NSInteger)index {
    NSUInteger i = index;
    for (SFFormItem *item in items) {
        [self.formItems insertObject:item atIndex:i++];
    }
}

- (void)bringItemToHead:(SFFormItem *)item {
    NSInteger index = [self.items indexOfObject:item];
    if (index == 0) {
        return;
    }
    if (index == NSNotFound) {
        [self insertItem:item atIndex:0];
    }
    else {
        [self removeItem:item];
        [self insertItem:item atIndex:0];
    }
}

- (void)sendItemToFoot:(SFFormItem *)item {
    NSInteger index = [self.items indexOfObject:item];
    if (index == self.items.count - 1) {
        return;
    }
    if (index == NSNotFound) {
        [self addItem:item];
    }
    else {
        [self removeItem:item];
        [self addItem:item];
    }
}

- (void)replaceItems:(NSArray<SFFormItem *> *)items {
    [self removeAllItems];
    [self addItems:items];
}

- (void)removeItem:(SFFormItem *)item {
    if ([self.items containsObject:item]) {
        [self.formItems removeObject:item];
    }
}

- (void)removeItems:(NSArray<SFFormItem *> *)items {
    [items enumerateObjectsUsingBlock:^(SFFormItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeItem:obj];
    }];
}

- (void)removeItemsWithKeys:(NSArray<NSString *> *)keys {
    if (!keys || keys.count == 0) {
        return;
    }
    [self.items enumerateObjectsUsingBlock:^(SFFormItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.key && [keys containsObject:obj.key]) {
            [self removeItem:obj];
        }
    }];
}

- (void)removeItemsButKeys:(NSArray<NSString *> *)keys {
    if (!keys || keys.count == 0) {
        [self removeAllItems];
    }
    else {
        [self.items enumerateObjectsUsingBlock:^(SFFormItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (!obj.key || ![keys containsObject:obj.key]) {
                [self removeItem:obj];
            }
        }];
    }
}

- (void)removeAllItems {
    [self removeItems:self.items];
}

- (NSArray<NSIndexPath *> *)indexPaths {
    NSMutableArray *indexPaths = [NSMutableArray new];
    [self.formItems enumerateObjectsUsingBlock:^(SFFormItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.indexPath) {
            [indexPaths addObject:obj.indexPath];
        }
    }];
    return indexPaths.copy;
}

#pragma mark - public(block)
- (SFFormSection *(^)(SFFormItem *))addItem {
    return ^SFFormSection *(SFFormItem *item){
        [self addItem:item];
        return self;
    };
}

- (SFFormSection *(^)(NSArray<SFFormItem *> *))addItems {
    return ^SFFormSection *((NSArray<SFFormItem *> *items)) {
        [self addItems:items];
        return self;
    };
}

- (SFFormSection *(^)(NSArray<SFFormItem *> *))replaceItems {
    return ^SFFormSection *((NSArray<SFFormItem *> *items)) {
        [self replaceItems:items];
        return self;
    };
}

- (SFFormSection *(^)(SFFormItem *))removeItem {
    return ^SFFormSection *(SFFormItem *item){
        [self removeItem:item];
        return self;
    };
}

- (SFFormSection *(^)(void))removeAllItems_ {
    return ^SFFormSection *(void){
        [self removeAllItems];
        return self;
    };
}

#pragma mark - set/get
- (NSMutableArray<SFFormItem *> *)formItems {
    return _formItems?:({
        _formItems = [NSMutableArray new];
        _formItems;
    });
}

- (NSArray<SFFormItem *> *)items {
    return self.formItems.copy;
}

@end
