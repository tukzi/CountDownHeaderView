//
//  LimitPriceHeaderView.h
//  DateHelper
//
//  Created by hesong on 15/6/24.
//  Copyright (c) 2015年 song.he. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCountDownLabel.h"
#import "CMTimeModel.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//颜色
#define Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)//屏高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)//屏宽

typedef void(^CMCountDownFinish)(CMTimerLabelType type);

@interface LimitPriceHeaderView : UIView

@property(nonatomic,strong)CMCountDownLabel *countDownLabel;
@property(nonatomic,strong)CMTimeModel *model;
@property (assign) CMTimerLabelType timerType;

@property (nonatomic,copy)CMCountDownFinish countDownFinished;

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *promptLabel;
@property(nonatomic,strong)UILabel *signLabel;
@property(nonatomic,strong)UIImageView *timeView;

@end
