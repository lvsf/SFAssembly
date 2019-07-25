//
//  UICollectionView+SFForm.m
//  SFAssembly
//
//  Created by YunSL on 2019/4/1.
//  Copyright © 2019年 YunSL. All rights reserved.
//

#import "UICollectionView+SFForm.h"
#import <objc/runtime.h>

@implementation UICollectionView (SFForm)

- (void)form_registerCellWithClassName:(NSString *)className reuseIdentifier:(nonnull NSString *)reuseIdentifier {
    NSAssert((className.length > 0 && NSClassFromString(className)), ([NSString stringWithFormat:@"[SFForm] can't find class with name '%@'",className]));
    NSMutableDictionary *registerCells = objc_getAssociatedObject(self, _cmd);
    if (registerCells == nil) {
        registerCells = [NSMutableDictionary new];
        objc_setAssociatedObject(self, _cmd, registerCells, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    NSString *key = [NSString stringWithFormat:@"%@_%@",className,reuseIdentifier];
    if (registerCells[key] == nil) {
        registerCells[key] = @(YES);
        if (([[NSBundle mainBundle] pathForResource:className ofType:@"nib"])) {
            [self registerNib:[UINib nibWithNibName:className bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
        }
        else {
            [self registerClass:NSClassFromString(className) forCellWithReuseIdentifier:reuseIdentifier];
        }
    }
}

@end
