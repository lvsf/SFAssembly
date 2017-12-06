//
//  SFFormViewComponent.m
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import "SFFormViewComponent.h"

@interface SFFormViewComponent()
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) SFFormComponentPosition horizontalPosition;
@property (nonatomic,assign) SFFormComponentPosition verticalPosition;
@property (nonatomic,assign) SFFormComponentLayouMode layoutMode;
@end

@implementation SFFormViewComponent
@synthesize componentView = _componentView;
@synthesize componentViewFrame = _componentViewFrame;

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentMode = UIViewContentModeScaleToFill;
        self.horizontalPosition = SFFormComponentPositionHeader;
        self.verticalPosition = SFFormComponentPositionCenter;
        self.clipsToBounds = NO;
    }
    return self;
}

+ (UIView *)componentView {
    return [UIView new];
}

- (BOOL)componentViewShouldDisplay {
    return YES;
}

- (void)componentViewDidLoad:(UIView *)view {
    
}

- (void)componentViewWillAppear:(UIView *)view {
    view.backgroundColor = self.backgroundColor;
    view.contentMode = self.contentMode;
    view.hidden = self.hidden;
    view.clipsToBounds = self.clipsToBounds;
}

- (CGSize)componentView:(UIView *)view boundSizeThatFits:(CGSize)size {
    return size;
}

@end
