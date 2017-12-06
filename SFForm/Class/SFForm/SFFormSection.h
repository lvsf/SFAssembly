//
//  SFFormSection.h
//  SFFormView
//
//  Created by YunSL on 17/10/20.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFFormItem.h"
#import "SFFormYYLabelComponent.h"

@interface SFFormSectionHeaderFooter : NSObject
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) UIEdgeInsets contentInsets;
@property (nonatomic,copy) NSString *className;
@property (nonatomic,copy) NSString *reuseIdentifier;
@property (nonatomic,copy) NSAttributedString *title;
@property (nonatomic,strong) UIColor *backgroundColor;
@property (nonatomic,assign,readonly) BOOL shouldLoadHeaderFooter;
@property (nonatomic,strong,readonly) SFFormYYLabelComponent *sectionLabel;
@end

@interface SFFormSection : NSObject
@property (nonatomic,strong,readonly) SFFormSectionHeaderFooter *header;
@property (nonatomic,strong,readonly) SFFormSectionHeaderFooter *footer;
@property (nonatomic,copy,readonly) NSArray <SFFormItem *> *items;
- (void)addItem:(SFFormItem *)item;
- (void)addItems:(NSArray<SFFormItem *> *)items;
- (void)insertItem:(SFFormItem *)item atIndex:(NSInteger)index;
- (void)insertItems:(NSArray<SFFormItem *> *)items atIndex:(NSInteger)index;
- (void)replaceItems:(NSArray<SFFormItem *> *)items;
- (void)removeItem:(SFFormItem *)item;
- (void)removeItems:(NSArray<SFFormItem *> *)items;
- (void)removeAllItems;
- (SFFormSection *(^)(SFFormItem *))addItem;
- (SFFormSection *(^)(NSArray<SFFormItem *> *))addItems;
- (SFFormSection *(^)(NSArray<SFFormItem *> *))replaceItems;
- (SFFormSection *(^)(SFFormItem *))removeItem;
@end
