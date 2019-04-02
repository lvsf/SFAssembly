//
//  SFImageViewComponent.h
//  SFAssembly
//
//  Created by YunSL on 2019/1/22.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "SFViewComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFImageViewComponent : SFViewComponent
@property (nonatomic,copy) NSString *imageURL;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong,readonly) UIImage *imageFormImageURL;
@end

NS_ASSUME_NONNULL_END
