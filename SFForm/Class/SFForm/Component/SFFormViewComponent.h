//
//  SFFormViewComponent.h
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/7.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SFFormComponentPosition) {
    SFFormComponentPositionHeader = 0, //置顶
    SFFormComponentPositionCenter,     //居中
    SFFormComponentPositionFooter      //置底
};

typedef NS_ENUM(NSInteger,SFFormComponentLayouMode) {
    SFFormComponentLayouModeFit = 0,
    SFFormComponentLayouModeFill,
};

@protocol SFFormComponentProtocol <NSObject>
@property (nonatomic,weak) UIView *componentView;
@property (nonatomic,assign) CGRect componentViewFrame;
@required
+ (UIView *)componentView;
- (void)componentViewDidLoad:(UIView *)view;
- (void)componentViewWillAppear:(UIView *)view;
- (BOOL)componentViewShouldDisplay;
- (CGSize)componentView:(UIView *)view boundSizeThatFits:(CGSize)size;
@end

@interface SFFormViewComponent : NSObject<SFFormComponentProtocol>
@property (nonatomic,copy) UIColor *backgroundColor;
@property (nonatomic) UIViewContentMode contentMode;
@property (nonatomic) BOOL hidden;
@property (nonatomic) BOOL clipsToBounds;
@end

@interface SFFormViewComponent(SFAddLayout)
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) SFFormComponentLayouMode layoutMode;
@property (nonatomic,assign) SFFormComponentPosition horizontalPosition;
@property (nonatomic,assign) SFFormComponentPosition verticalPosition;
@end
