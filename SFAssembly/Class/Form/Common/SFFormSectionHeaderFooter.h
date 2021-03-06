//
//  SFFormSectionHeaderFooter.h
//  QuanYou
//
//  Created by YunSL on 2018/1/24.
//  Copyright © 2018年 YunSL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SFFormSectionHeaderFooterKind) {
    SFFormSectionKindHeader = 0,
    SFFormSectionKindFooter
};

@class SFFormSectionHeaderFooter;

@protocol SFFormSectionHeaderFooterDelegate<NSObject>
@optional
- (void)formSectionHeaderFooterDidSelected:(SFFormSectionHeaderFooter *)headerFooter;
@end

@interface SFFormSectionHeaderFooter : NSObject
@property (nonatomic,assign) SFFormSectionHeaderFooterKind kind;
@property (nonatomic,copy) NSString *className;
@property (nonatomic,copy) NSString *reuseIdentifier;
@property (nonatomic,assign) BOOL cacheHeight;
@property (nonatomic,strong) id object;
@property (nonatomic,weak) id<SFFormSectionHeaderFooterDelegate> delegate;
- (BOOL)shouldLoadHeaderFooter;
@end
