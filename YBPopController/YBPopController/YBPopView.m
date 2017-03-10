//
//  YBPopView.m
//  YBPopController
//
//  Created by 王亚彬 on 2017/3/10.
//  Copyright © 2017年 王亚彬. All rights reserved.
//

#import "YBPopView.h"
#import "UIView+YBLayout.h"

@interface YBPopView ()

@property(nonatomic, weak) UITextField *textF;

@end

@implementation YBPopView

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self yb_in:self.textF duration:YBLayoutInCenterBottom size:CGSizeMake(200, 30)];
    }
    return self;
}

#pragma mark - 懒加载
- (UITextField *)textF {
    if (_textF == nil) {
        UITextField *textF = [UITextField new];
        textF.backgroundColor = [UIColor orangeColor];
        [self addSubview:textF];
        _textF = textF;
    }
    return _textF;
}


@end
