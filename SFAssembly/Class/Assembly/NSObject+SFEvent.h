//
//  NSObject+SFEvent.h
//  HMSSetupApp
//
//  Created by YunSL on 2017/11/9.
//  Copyright © 2017年 HMS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 事件回调block

 @param actionObject   添加事件的对象
 @param sender         触发事件的对象
 @param userInfo       用户携带的对象
 */
typedef void(^SFEventActionBlock)(id actionObject, id sender, id userInfo);

@interface NSObject (SFEvent)
@property (nonatomic,copy,readonly) NSArray<NSString *> *action_controlEvents;
- (void)addActionForControlEvents:(UIControlEvents)controlEvents actionBlock:(SFEventActionBlock)actionBlock;
- (void)addActionForSelectorEvent:(SEL)selector actionBlock:(SFEventActionBlock)actionBlock;
- (void)addActionForCustomEvent:(NSString *)eventKey actionBlock:(SFEventActionBlock)actionBlock;
- (void)addActionForTableViewDidSelectedWithBlock:(void(^)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath))actionBlock;
- (void)addActionForCollectionViewDidSelectedWithBlock:(void(^)(UICollectionView *collectionView, UICollectionViewCell *cell, NSIndexPath *indexPath))actionBlock;
- (void)sendActionsForControlEvents:(UIControlEvents)controlEvents sender:(id)sender userInfo:(id)userInfo;
- (void)sendActionsForSelectorEvent:(SEL)selector sender:(id)sender userInfo:(id)userInfo;
- (void)sendActionsForCustomEvent:(NSString *)eventKey sender:(id)sender userInfo:(id)userInfo;
- (void)sendActionsForTableViewDidSelected:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
- (void)sendActionsForCollectionViewDidSelected:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@end
