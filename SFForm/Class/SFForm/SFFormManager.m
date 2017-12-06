//
//  SFFormManager.m
//  SFFormView
//
//  Created by YunSL on 17/10/20.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import "SFFormManager.h"

@interface SFFormManager()
@property (nonatomic,strong) NSMutableArray <SFFormSection *> *formSections;
@property (nonatomic,strong) NSMutableDictionary *holdItems;
@end

@implementation SFFormManager
@synthesize defaultSection = _defaultSection;
@synthesize sections = _formSection;

#pragma mark - SFFormManagerProtocol
+ (Class)formManagerSectionClass {
    return [SFFormSection class];
}

+ (Class)formManagerItemClass {
    return [SFFormItem class];
}

#pragma mark - public
- (void)clearData {
    if (_defaultSection) {
        _defaultSection = nil;
    }
    [self removeAllSections];
}

- (void)addSections:(NSArray<SFFormSection *> *)sections {
    [sections enumerateObjectsUsingBlock:^(SFFormSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSection:obj];
    }];
}

- (void)addSection:(SFFormSection *)section {
    [self.formSections addObject:section];
}

- (void)replaceSections:(NSArray<SFFormSection *> *)sections {
    [self clearData];
    [self addSections:sections];
}

- (void)removeSection:(SFFormSection *)section {
    [self.formSections removeObject:section];
}

- (void)removeSections:(NSArray<SFFormSection *> *)sections {
    [sections enumerateObjectsUsingBlock:^(SFFormSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeSection:obj];
    }];
}

- (void)removeAllSections {
    [self removeSections:self.sections];
}

- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath {
    SFFormSection *section = [self sectionAtIndex:indexPath.section];
    section.removeItem([self itemAtIndexPath:indexPath]);
}

- (SFFormSection *)sectionAtIndex:(NSInteger)index {
    return [self.formSections objectAtIndex:index];
}

- (SFFormItem *)itemAtIndexPath:(NSIndexPath *)indexPath {
    SFFormSection *section = [self sectionAtIndex:indexPath.section];
    return [section.items objectAtIndex:indexPath.row];
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

- (NSMutableDictionary *)holdItems {
    return _holdItems?:({
        _holdItems = [NSMutableDictionary new];
        _holdItems;
    });
}

- (NSString *)validateMessage {
    __block NSString *validateMessage = nil;
    [self.items enumerateObjectsUsingBlock:^(SFFormItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.validator) {
            validateMessage = obj.validator(obj);
            *stop = YES;
        }
    }];
    return validateMessage;
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
    [self.holdItems setObject:object forKey:aKey];
}

- (SFFormItem *)objectForKeyedSubscript:(id)key {
    return [self.holdItems objectForKey:key];
}

@end
