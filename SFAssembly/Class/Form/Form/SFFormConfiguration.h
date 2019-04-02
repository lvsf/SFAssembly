//
//  SFFormConfiguration.h
//  SFAssembly
//
//  Created by YunSL on 2019/4/1.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFFormConfiguration : NSObject
@property (nonatomic,copy) NSString *(^reuseIdentifierForClassName)(NSString *className);
@end

NS_ASSUME_NONNULL_END
