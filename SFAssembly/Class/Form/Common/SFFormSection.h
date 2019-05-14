//
//  SFFormSection.h
//  SFFormView
//
//  Created by YunSL on 17/10/20.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFFormItem.h"

@interface SFFormSection : NSObject
@property (nonatomic,assign) NSInteger sectionIndex;
@property (nonatomic,copy,readonly) NSArray<SFFormItem *> *items;
- (void)addItem:(SFFormItem *)item;
- (void)addItem:(SFFormItem *)item forKey:(NSString *)key;
- (void)addItems:(NSArray<SFFormItem *> *)items;
- (void)insertItem:(SFFormItem *)item atIndex:(NSInteger)index;
- (void)insertItems:(NSArray<SFFormItem *> *)items atIndex:(NSInteger)index;
- (void)bringItemToHead:(SFFormItem *)item;
- (void)sendItemToFoot:(SFFormItem *)item;
- (void)replaceItems:(NSArray<SFFormItem *> *)items;
- (void)removeItem:(SFFormItem *)item;
- (void)removeItems:(NSArray<SFFormItem *> *)items;
- (void)removeItemsWithKeys:(NSArray<NSString *> *)keys;
- (void)removeItemsButKeys:(NSArray<NSString *> *)keys;
- (void)removeAllItems;
- (NSArray<NSIndexPath *> *)indexPaths;
- (SFFormSection *(^)(SFFormItem *))addItem;
- (SFFormSection *(^)(NSArray<SFFormItem *> *))addItems;
- (SFFormSection *(^)(NSArray<SFFormItem *> *))replaceItems;
- (SFFormSection *(^)(SFFormItem *))removeItem;
- (SFFormSection *(^)(void))removeAllItems_;
@end
