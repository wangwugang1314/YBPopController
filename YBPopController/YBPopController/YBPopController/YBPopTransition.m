//
//  XWPresentOneTransition.m
//  zhuanChengAnimation
//
//  Created by FuYun on 16/10/19.
//  Copyright © 2016年 FuYun. All rights reserved.
//

#import "YBPopTransition.h"

@interface YBPopTransition ()

@property(nonatomic, assign) YBPopTransitionType type;

@end

@implementation YBPopTransition

//根据定义的枚举初始化的两个方法
+ (instancetype)transitionWithTransitionType:(YBPopTransitionType)type{
    return [[YBPopTransition alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(YBPopTransitionType)type{
    YBPopTransition *popTransition = [YBPopTransition new];
    popTransition.type = type;
    return popTransition;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //为了将两种动画的逻辑分开，变得更加清晰，我们分开书写逻辑，
    switch (self.type) {
        case YBPopTransitionPresent:
            [self presentAnimation:transitionContext];
            break;
            
        case YBPopTransitionDismiss:
            [self dismissAnimation:transitionContext];
            break;
    }
}

//实现present动画逻辑代码
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //通过viewControllerForKey取出转场前后的两个控制器，这里toVC就是vc1、fromVC就是vc2
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    //设置vc2的frame，因为这里vc2present出来不是全屏，且初始的时候在底部，如果不设置frame的话默认就是整个屏幕咯，这里containerView的frame就是整个屏幕
    toVC.view.frame = [UIScreen mainScreen].bounds;
    toVC.view.backgroundColor = [UIColor colorWithRed:12 / 255.0 green:12 / 255.0 blue:12 / 255.0 alpha:0];
    //开始动画吧，使用产生弹簧效果的动画API
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.backgroundColor = [UIColor colorWithRed:12 / 255.0 green:12 / 255.0 blue:12 / 255.0 alpha:0.5];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
//实现dismiss动画逻辑代码
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //注意在dismiss的时候fromVC就是vc2了，toVC才是VC1了，注意这个关系
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //动画吧
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.backgroundColor = [UIColor colorWithRed:12 / 255.0 green:12 / 255.0 blue:12 / 255.0 alpha:0];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
