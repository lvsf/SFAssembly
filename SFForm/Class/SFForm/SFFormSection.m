//
//  SFFormSection.m
//  SFFormView
//
//  Created by YunSL on 17/10/20.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFFormSection.h"
#import <YYCategories/NSArray+YYAdd.h>

@interface SFFormSection()
@property (nonatomic,strong) NSMutableArray <SFFormItem *> *formItems;
@end

@implementation SFFormSection

- (void)addItem:(SFFormItem *)item {
    if (![self.items containsObject:item]) {
        [self.formItems addObject:item];
    }
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
    [self.formItems insertObjects:items atIndex:index];
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

- (void)removeAllItems {
    [self removeItems:self.items];
}

- (SFFormSection *(^)(SFFormItem *))addItem {
    return ^SFFormSection*(SFFormItem *item){
        [self addItem:item];
        return self;
    };
}

- (SFFormSection *(^)(NSArray<SFFormItem *> *))addItems {
    return ^SFFormSection*((NSArray<SFFormItem *> *items)) {
        [self addItems:items];
        return self;
    };
}

- (SFFormSection *(^)(NSArray<SFFormItem *> *))replaceItems {
    return ^SFFormSection*((NSArray<SFFormItem *> *items)) {
        [self replaceItems:items];
        return self;
    };
}

- (SFFormSection *(^)(SFFormItem *))removeItem {
    return ^SFFormSection*(SFFormItem *item){
        [self removeItem:item];
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
