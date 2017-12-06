//
//  SFFormItem.h
//  SFFormView
//
//  Created by YunSL on 17/10/19.
//  Copyright © 2017年 YunSL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSObject+SFAddForm.h"

@protocol SFFormActionDelegate <NSObject>
@end

@interface SFFormItem : NSObject
/**
 cell类名
 */
@property (nonatomic,copy) NSString *className;
/**
 cell重用标志
 */
@property (nonatomic,copy) NSString *reuseIdentifier;

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,weak) id cell;

@property (nonatomic,strong) id object;
@property (nonatomic,strong) id object1;

@property (nonatomic,copy) NSString *(^validator)(id item);

/**
 cell事件代理
 */
@property (nonatomic,weak) id<SFFormActionDelegate> delegate;

@end
