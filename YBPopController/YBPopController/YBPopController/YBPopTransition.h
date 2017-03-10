//
//  XWPresentOneTransition.h
//  zhuanChengAnimation
//
//  Created by FuYun on 16/10/19.
//  Copyright © 2016年 FuYun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YBPopTransitionType) {
    YBPopTransitionPresent = 0,//管理present动画
    YBPopTransitionDismiss//管理dismiss动画
};

@interface YBPopTransition : NSObject<UIViewControllerAnimatedTransitioning>

//根据定义的枚举初始化的两个方法
+ (instancetype)transitionWithTransitionType:(YBPopTransitionType)type;
- (instancetype)initWithTransitionType:(YBPopTransitionType)type;

@end
