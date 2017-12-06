//
//  NSObject+SFAddForm.h
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/9.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 事件回调block

 @param object   添加事件的对象
 @param sender   触发事件的对象
 @param userInfo 用户携带的对象
 */
typedef void(^SFFormEventBlock)(id object, id sender, id userInfo);

@interface NSObject (SFAddForm)

@property (nonatomic,copy,readonly) NSArray *controlEvents;
- (void)addProtocolEvent:(SEL)event block:(SFFormEventBlock)block;
- (void)addControlEvent:(UIControlEvents)events block:(SFFormEventBlock)block;
- (void)addCustomEvent:(NSString*)eventKey block:(SFFormEventBlock)block;
- (void)excuteProtocolEvent:(SEL)event sender:(id)sender userInfo:(id)userInfo;
- (void)excuteControlEvent:(UIControlEvents)events sender:(id)sender userInfo:(id)userInfo;
- (void)excuteCustomEvent:(NSString*)eventKey sender:(id)sender userInfo:(id)userInfo;
@end
