//
//  ViewController.m
//  CMCountDownHeaderView
//
//  Created by hesong on 15/7/1.
//  Copyright (c) 2015年 hesong. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ProjectViewController.h"
#import "LimitPriceHeaderView.h"
#import "CMLimitPriceAlertView.h"

@interface ViewController (){
    //    AppDelegate *appDelegete;
}

@property(nonatomic,strong)AppDelegate *appDelegete;

@property(nonatomic,strong)LimitPriceHeaderView *headView;

@property(nonatomic,strong)CMTimeModel *model;

@property(nonatomic,strong)CMLimitPriceAlertView *alertView;

@property(nonatomic,strong)CMTimeModel *appdelegateModel;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_appDelegete.model) {
        _headView.model = _appDelegete.model;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"限时特价";
    _appDelegete = [AppDelegate getAppDelegate];
    
    _headView = [[LimitPriceHeaderView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 110)];
    _headView.backgroundColor = Color(240, 234, 231, 1);
    _headView.countDownFinished = ^(CMTimerLabelType type){
        
        switch (type) {
            case CMTimerLabelTypeUnStart:{
                NSLog(@"还未开始");
            }
                break;
            case CMTimerLabelTypeStarting:{
                NSLog(@"进行中");
            }
                break;
            default:{
                
                NSLog(@"结束了");
            }
                break;
        }
    };
    if (_appDelegete.model) {
        _headView.model = _appDelegete.model;
    }
    [self.view addSubview:_headView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(0, CGRectGetMaxY(_headView.frame) + 20, 40, 40);
    [btn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)tapAction{
    CMLimitPriceAlertView *alertView =[[CMLimitPriceAlertView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    alertView.rushToPurchase = ^(){
        NSLog(@"去抢购");
        
    };
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
