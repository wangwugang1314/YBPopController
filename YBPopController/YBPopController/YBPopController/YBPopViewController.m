//
//  YBVC.m
//  zhuanChengAnimation
//
//  Created by FuYun on 16/10/19.
//  Copyright © 2016年 FuYun. All rights reserved.
//

#import "YBPopViewController.h"
#import "YBPopTransition.h"

#define YBPopViewControllerScale 0.9

@interface YBPopViewController ()<UIViewControllerTransitioningDelegate>

@property(nonatomic, weak) UIView *popView;
@property(nonatomic, assign) BOOL isClick;

@end

@implementation YBPopViewController

+ (void)popViewWithView:(UIView *)popView clickHiden:(BOOL)clickHiden{
    YBPopViewController *controller = [YBPopViewController new];
    controller.view.userInteractionEnabled = NO;
    controller.popView = popView;
    controller.isClick = clickHiden;
    [controller.view addSubview:popView];
    CGFloat sW = [UIScreen mainScreen].bounds.size.width;
    CGFloat sH = [UIScreen mainScreen].bounds.size.height;
    CGSize popViewSize = popView.frame.size;
    CGFloat x = (sW - popViewSize.width) * 0.5;
    CGFloat y = (sH - popViewSize.height) * 0.5;
    popView.alpha = 0;
    popView.frame = CGRectMake(x , y, popViewSize.width, popViewSize.height);
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:controller animated:YES completion:nil];
}

+ (void)hideVC{
//    [[YBControlBoxModel sharedControlBoxModel].popViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showAnimation];
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        //为什么要设置为Custom，在最后说明.
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

/// 显示动画
- (void)showAnimation{
    __weak typeof(self) weakSelf = self;
    self.popView.alpha = 0;
    self.popView.transform = CGAffineTransformMakeScale(YBPopViewControllerScale, YBPopViewControllerScale);
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.popView.alpha = 1;
        weakSelf.popView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        weakSelf.view.userInteractionEnabled = YES;
    }];
}

/// 隐藏动画
- (void)hiddenAnimation{
    __weak typeof(self) weakSelf = self;
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.popView.alpha = 0;
        weakSelf.popView.transform = CGAffineTransformMakeScale(YBPopViewControllerScale, YBPopViewControllerScale);
    } completion:^(BOOL finished) {
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!self.isClick) return;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [YBPopTransition transitionWithTransitionType:YBPopTransitionPresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    [self hiddenAnimation];
    //这里我们初始化dismissType
    return [YBPopTransition transitionWithTransitionType:YBPopTransitionDismiss];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent; // 白色
}

@end
