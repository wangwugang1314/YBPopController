//
//  ViewController.m
//  YBPopController
//
//  Created by 王亚彬 on 2017/3/9.
//  Copyright © 2017年 王亚彬. All rights reserved.
//

#import "ViewController.h"
#import "YBPopViewController.h"
#import "YBPopView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    YBPopView *view = [[YBPopView alloc] initWithFrame:CGRectMake(0, 0, 300, [UIScreen mainScreen].bounds.size.height - 100)];
    view.backgroundColor = [UIColor redColor];
    
    [YBPopViewController popViewWithView:view clickHiden:YES];
}


@end
