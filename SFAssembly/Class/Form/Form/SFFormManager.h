//
//  SFFormManager.h
//  SFAssembly
//
//  Created by YunSL on 2019/4/1.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SFFormSection.h"
#import "SFFormItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SFFormManagerProtocol <NSObject>
@required
+ (Class)formManagerSectionClass;
+ (Class)formManagerItemClass;
@end

@interface SFFormManager : NSObject<SFFormManagerProtocol>
@property (nonatomic,strong,readonly) SFFormSection *defaultSection;
@property (nonatomic,copy,readonly) NSArray<SFFormSection *> *sections;
@property (nonatomic,copy,readonly) NSArray<SFFormItem *> *items;
@property (nonatomic,copy) void (^scrollToIndexPath)(void);
- (void)addSection:(SFFormSection *)section;
- (void)addSections:(NSArray<SFFormSection *> *)sections;
- (void)insertSection:(SFFormSection *)section atIndex:(NSInteger)sectionIndex;
- (void)replaceSections:(NSArray<SFFormSection *> *)sections;
- (void)removeSection:(SFFormSection *)section;
- (void)removeSectionAtIndex:(NSInteger)sectionIndex;
- (void)removeSections:(NSArray<SFFormSection *> *)sections;
- (void)removeAllSections;
- (void)removeAllSectionsBut:(NSArray<SFFormSection *> *)sections;
- (void)removeAllSectionsButDefaultSection;
- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)bringSection:(SFFormSection *)section toIndex:(NSInteger)sectionIndex;
- (void)clear;
- (NSString *)invalidateMessage;
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

NS_ASSUME_NONNULL_END
