//
//  SFFormManager.h
//  SFFormView
//
//  Created by YunSL on 17/10/20.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFFormSection.h"
#import "SFFormItem.h"

@protocol SFFormManagerProtocol <NSObject>
@required
+ (Class)formManagerSectionClass;
+ (Class)formManagerItemClass;
@end

@interface SFFormManager : NSObject<SFFormManagerProtocol>
@property (nonatomic,strong,readonly) SFFormSection *defaultSection;
@property (nonatomic,copy,readonly) NSArray<SFFormSection *> *sections;
@property (nonatomic,copy,readonly) NSArray<SFFormItem *> *items;
@property (nonatomic,copy,readonly) NSString *validateMessage;
- (void)addSection:(SFFormSection *)section;
- (void)addSections:(NSArray<SFFormSection *> *)sections;
- (void)replaceSections:(NSArray<SFFormSection *> *)sections;
- (void)removeSection:(SFFormSection *)section;
- (void)removeSections:(NSArray<SFFormSection *> *)sections;
- (void)removeAllSections;
- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)clearData;
- (SFFormSection *)sectionAtIndex:(NSInteger)index;
- (SFFormItem *)itemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface SFFormManager(SFAddBlock)
- (SFFormManager *(^)(SFFormSection *))addSection;
- (SFFormManager *(^)(NSArray<SFFormSection *> *))addSections;
- (SFFormManager *(^)(NSArray<SFFormSection *> *))replaceSections;
- (SFFormManager *(^)(SFFormSection *))removeSection;
- (SFFormManager *(^)(NSIndexPath *))removeItemAtIndexPath;
@end

@interface SFFormManager(SFAddSubscript)
- (void)setObject:(id)object forKeyedSubscript:(id<NSCopying>)aKey;
- (SFFormItem *)objectForKeyedSubscript:(id)key;
@end
