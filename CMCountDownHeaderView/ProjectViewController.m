//
//  ProjectViewController.m
//  DateHelper
//
//  Created by hesong on 15/6/24.
//  Copyright (c) 2015年 song.he. All rights reserved.
//

#import "ProjectViewController.h"
#import "LimitPriceHeaderView.h"
#import "AppDelegate.h"
#import "CMLimitPriceAlertView.h"


@interface ProjectViewController (){
    AppDelegate *appDelegete;
}

@property(nonatomic,strong)LimitPriceHeaderView *headView;

@property(nonatomic,strong)CMTimeModel *model;

@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"项目列表";
    
    appDelegete = [AppDelegate getAppDelegate];
 
    _headView = [[LimitPriceHeaderView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 110)];
    _headView.backgroundColor = Color(240, 234, 231, 1);
    _headView.countDownFinished = ^(CMTimerLabelType type){
        
        switch (type) {
            case CMTimerLabelTypeUnStart:{
                NSLog(@"项目列表--还未开始");
            }
                break;
            case CMTimerLabelTypeStarting:{
                NSLog(@"项目列表--进行中");
            }
                break;
            default:{
                NSLog(@"项目列表--结束了");
            }
                break;
        }
    };
    if (appDelegete.model) {
        _headView.model = appDelegete.model;
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
