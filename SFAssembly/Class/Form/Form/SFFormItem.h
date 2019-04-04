//
//  SFFormItem.h
//  SFAssembly
//
//  Created by YunSL on 2019/4/1.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFFormItem : NSObject
@property (nonatomic,copy) NSString *key;
@property (nonatomic,copy) NSString *reuseIdentifier;
@property (nonatomic,copy) NSString *className;
@property (nonatomic,copy) NSString *(^validator)(SFFormItem *item);
@property (nonatomic,assign) BOOL verify;
@property (nonatomic,strong) id object;
@property (nonatomic,strong) NSIndexPath *indexPath;
@end

NS_ASSUME_NONNULL_END
