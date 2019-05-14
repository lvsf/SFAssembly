//
//  SFFormManager.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/1.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFFormManager.h"

@interface SFFormManager()
@property (nonatomic,strong) NSMutableArray<SFFormSection *> *formSections;
@property (nonatomic,strong) NSMutableDictionary<NSString *, SFFormItem *> *holdFormItems;
@end

@implementation SFFormManager
@synthesize defaultSection = _defaultSection;
@synthesize sections = _sections;

#pragma mark - SFFormManagerProtocol
+ (Class)formManagerSectionClass {
    return [SFFormSection class];
}

+ (Class)formManagerItemClass {
    return [SFFormItem class];
}

#pragma mark - public
- (void)addSections:(NSArray<SFFormSection *> *)sections {
    [sections enumerateObjectsUsingBlock:^(SFFormSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSection:obj];
    }];
}

- (void)addSection:(SFFormSection *)section {
    [self.formSections addObject:section];
}

- (void)insertSection:(SFFormSection *)section atIndex:(NSInteger)sectionIndex {
    [self.formSections insertObject:section atIndex:sectionIndex];
}

- (void)replaceSections:(NSArray<SFFormSection *> *)sections {
    [self clear];
    [self addSections:sections];
}

- (void)removeSection:(SFFormSection *)section {
    [self.formSections removeObject:section];
}

- (void)removeSectionAtIndex:(NSInteger)sectionIndex {
    [self.formSections removeObjectAtIndex:sectionIndex];
}

- (void)removeSections:(NSArray<SFFormSection *> *)sections {
    [sections enumerateObjectsUsingBlock:^(SFFormSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeSection:obj];
    }];
}

- (void)removeAllSections {
    [self removeSections:self.sections];
}

- (void)removeAllSectionsBut:(NSArray<SFFormSection *> *)sections {
    if (sections.count > 0) {
        [self.sections enumerateObjectsUsingBlock:^(SFFormSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![sections containsObject:obj]) {
                [self removeSection:obj];
            }
        }];
    }
    else {
        [self removeAllSections];
    }
}

- (void)removeAllSectionsButDefaultSection {
    [self removeAllSectionsBut:_defaultSection?@[_defaultSection]:nil];
}

- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath {
    SFFormSection *section = [self sectionAtIndex:indexPath.section];
    section.removeItem([self itemAtIndexPath:indexPath]);
}

- (void)bringSection:(SFFormSection *)section toIndex:(NSInteger)sectionIndex {
    [self.formSections exchangeObjectAtIndex:[self.formSections indexOfObject:section] withObjectAtIndex:sectionIndex];
}

- (void)clear {
    if (_defaultSection) {
        _defaultSection = nil;
    }
    [self removeAllSections];
}

- (SFFormSection *)sectionAtIndex:(NSInteger)index {
    if (index < self.formSections.count) {
        return [self.formSections objectAtIndex:index];
    }
    return nil;
}

- (SFFormItem *)itemAtIndexPath:(NSIndexPath *)indexPath {
    SFFormSection *section = [self sectionAtIndex:indexPath.section];
    SFFormItem *item = nil;
    if (section && indexPath.row < section.items.count) {
        item = [section.items objectAtIndex:indexPath.row];
    }
    return item;
}

- (NSString *)invalidateMessage {
    __block NSString *invalidateMessage = nil;
    [self.items enumerateObjectsUsingBlock:^(SFFormItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.validator && obj.verify) {
            invalidateMessage = obj.validator(obj);
            if (invalidateMessage.length > 0) {
                *stop = YES;
            }
        }
    }];
    return invalidateMessage;
}

#pragma mark - set/get
- (SFFormSection *)defaultSection {
    return _defaultSection?:({
        _defaultSection = [[self.class formManagerSectionClass] new];
        self.addSection(_defaultSection);
        _defaultSection;
    });
}

- (NSMutableArray<SFFormSection *> *)formSections {
    return _formSections?:({
        _formSections = [NSMutableArray new];
        _formSections;
    });
}

- (NSArray<SFFormSection *> *)sections {
    return self.formSections.copy;
}

- (NSArray<SFFormItem *> *)items {
    NSMutableArray *items = [NSMutableArray new];
    [self.sections enumerateObjectsUsingBlock:^(SFFormSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [items addObjectsFromArray:obj.items];
    }];
    return items.copy;
}

- (NSMutableDictionary<NSString *,SFFormItem *> *)holdFormItems {
    return _holdFormItems?:({
        _holdFormItems = [NSMutableDictionary new];
        _holdFormItems;
    });
}

@end

@implementation SFFormManager(SFAddBlock)

- (SFFormManager *(^)(NSArray<SFFormSection *> *))addSections {
    return ^SFFormManager *(NSArray<SFFormSection *> *sections) {
        [self addSections:sections];
        return self;
    };
}

- (SFFormManager *(^)(NSArray<SFFormSection *> *))replaceSections {
    return ^SFFormManager *(NSArray<SFFormSection *> *sections) {
        [self replaceSections:sections];
        return self;
    };
}

- (SFFormManager *(^)(NSIndexPath *))removeItemAtIndexPath {
    return ^SFFormManager *(NSIndexPath *indexPath) {
        [self removeItemAtIndexPath:indexPath];
        return self;
    };
}

- (SFFormManager *(^)(SFFormSection *))addSection {
    return ^SFFormManager *(SFFormSection *section) {
        [self addSection:section];
        return self;
    };
}

- (SFFormManager *(^)(SFFormSection *))removeSection {
    return ^SFFormManager *(SFFormSection *section) {
        [self removeSection:section];
        return self;
    };
}

@end

@implementation SFFormManager(SFAddSubscript)

- (void)setObject:(id)object forKeyedSubscript:(id<NSCopying>)aKey {
    [self.holdFormItems setObject:object forKey:aKey];
}

- (SFFormItem *)objectForKeyedSubscript:(id)key {
    return [self.holdFormItems objectForKey:key];
}

@end
