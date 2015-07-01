//
//  LimitPriceHeaderView.m
//  DateHelper
//
//  Created by hesong on 15/6/24.
//  Copyright (c) 2015年 song.he. All rights reserved.
//

#import "LimitPriceHeaderView.h"

@implementation LimitPriceHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)_initView{
    if (self.subviews) {
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
    }

    _promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, 20)];
    _promptLabel.textColor = UIColorFromRGB(0xe83260);
    _promptLabel.textAlignment = NSTextAlignmentCenter;
    _promptLabel.font = [UIFont systemFontOfSize:12];
    _promptLabel.text = _model.hintStr;
    [self addSubview:_promptLabel];
    
    _timeView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 255)/2, CGRectGetMaxY(_promptLabel.frame) + 10, 255, 40)];
    _timeView.contentMode = UIViewContentModeScaleAspectFill;
    _timeView.image = [UIImage imageNamed:(_timerType == CMTimerLabelTypeEnd) ? @"xstj_yishouqing_bj": @"xstj_jijiangkais_bj"];
    
    [self addSubview:_timeView];
    
    _signLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,(35 -20)/2, 76, 20)];
    _signLabel.text = (_timerType == CMTimerLabelTypeEnd) ? @"已售罄" : ((_timerType == CMTimerLabelTypeStarting) ? @"抢购中" : @"即将开始");
    _signLabel.textAlignment = NSTextAlignmentCenter;
    _signLabel.font = [UIFont systemFontOfSize:12];
    _signLabel.textColor = UIColorFromRGB(0xffd200);
    [_timeView addSubview:_signLabel];

    [self configureTimeShow];
    
}

- (void)configureTimeShow{
    
    switch (_timerType) {
        case CMTimerLabelTypeUnStart:
        {
            //未开始
            !_countDownFinished ? :_countDownFinished(_timerType);

            _countDownLabel = [[CMCountDownLabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_signLabel.frame), -3, _timeView.frame.size.width - 76, 40)];
            _countDownLabel.textAlignment = NSTextAlignmentCenter;
            _countDownLabel.font = [UIFont systemFontOfSize:18];
            _countDownLabel.textColor = UIColorFromRGB(0xe83260);
            [_countDownLabel setCountDownTime:[_model.startDate doubleValue] - [_model.currentDate doubleValue]];
            [_countDownLabel startWithEndingBlock:^(NSTimeInterval countTime) {
                //计时结束，进入进行中任务倒计时
                _timerType = CMTimerLabelTypeStarting;
                [self _initView];
                !_countDownFinished ? :_countDownFinished(_timerType);
                
            }];
            [_timeView addSubview:_countDownLabel];
        }
            break;
        case CMTimerLabelTypeStarting:{//进行中
            
            _countDownLabel = [[CMCountDownLabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_signLabel.frame), -3, _timeView.frame.size.width - 76, 40)];
            _countDownLabel.textAlignment = NSTextAlignmentCenter;
            _countDownLabel.font = [UIFont systemFontOfSize:18];
            _countDownLabel.textColor = UIColorFromRGB(0xe83260);
            [_countDownLabel setCountDownTime:[_model.endDate doubleValue] - [_model.currentDate doubleValue]];
            [_countDownLabel startWithEndingBlock:^(NSTimeInterval countTime) {
                //计时结束，进入结束任务
                _timerType = CMTimerLabelTypeEnd;
                [self _initView];
                !_countDownFinished ? :_countDownFinished(_timerType);

            }];
            [_timeView addSubview:_countDownLabel];
        }
            break;
            
        default:{
            
            _promptLabel.textColor = UIColorFromRGB(0xaaaaaa);
            _signLabel.textColor = UIColorFromRGB(0xaaaaaa);
            if (_countDownLabel) {
                [_countDownLabel removeFromSuperview];
                _countDownLabel = nil;
            }
            //结束
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_signLabel.frame), -3, _timeView.frame.size.width - 76, 40)];
            label.text = @"请明天准时来哦!";
            label.textColor = UIColorFromRGB(0xaaaaaa);
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            [_timeView addSubview:label];
            
        }
            break;
    }
}

- (void)setModel:(CMTimeModel *)model{
    _model = model;
    _timerType = model.timerType;
    
    [self _initView];
}



@end
