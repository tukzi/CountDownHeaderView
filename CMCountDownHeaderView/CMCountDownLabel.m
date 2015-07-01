//
//  CMCountDownLabel.m
//  DateHelper
//
//  Created by song.he on 15/6/23.
//  Copyright (c) 2015年 song.he. All rights reserved.
//

#import "CMCountDownLabel.h"

#define kDefaultFireIntervalNormal  0.1
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface CMCountDownLabel (){
    NSTimeInterval timeUserValue;
    NSDate *startCountDate;
    NSDate *date1970;
}

@property (strong) NSTimer *timer;

- (void)setup;
- (void)updateLabel;

@end

@implementation CMCountDownLabel

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        [self setup];
    }
    return self;
}

#pragma mark - Private method

-(void)setup{
    date1970 = [NSDate dateWithTimeIntervalSince1970:0];
    [self updateLabel];
}

-(void)startWithEndingBlock:(void(^)(NSTimeInterval))end{
    self.endedBlock = end;
    [self start];
}

- (void)setCountDownTime:(NSTimeInterval)time{
    
    timeUserValue = (time < 0)? 0 : time;
    [self updateLabel];
}

-(void)pause{
    if(_counting){
        [_timer invalidate];
        _timer = nil;
        _counting = NO;
    }
}

#pragma mark - Timer Control Method
-(void)updateLabel{
    
    NSTimeInterval timeDiff = [[NSDate date] timeIntervalSinceDate:startCountDate];
    BOOL timerEnded = false;

    if (_counting)
    {
        if(timeDiff >= timeUserValue)
        {
            [self pause];
            startCountDate = nil;
            timerEnded = true;
        }
    }
    
    NSTimeInterval atTime = ((timeUserValue - timeDiff) < 0 ? 0 : (timeUserValue - timeDiff));
    NSMutableAttributedString *customtext = [self timerLabel:self customTextToDisplayAtTime:atTime];
    if ([customtext length])
    {
        self.attributedText = customtext;
    }else
    {
        self.text = @"";
    }
    
    if(timerEnded){
        [_timer invalidate];
        _timer = nil;
        !_endedBlock ? :_endedBlock(timeUserValue);
    }

}

-(void)start{
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:kDefaultFireIntervalNormal target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
        
    if(startCountDate == nil){
        startCountDate = [NSDate date];
    }
    _counting = YES;
    [_timer fire];
}

-(NSMutableAttributedString *)timerLabel:(CMCountDownLabel*)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time{
        int second = (int)time  % 60;
        int minute = ((int)time / 60) % 60;
        int hours = time / 3600;
        NSString *timeStr = [NSString stringWithFormat:@"%d 小时 %d 分 %d 秒",hours,minute,second];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:timeStr];
        NSRange range1 = [timeStr rangeOfString:[NSString stringWithFormat:@"小时"]];
        NSRange range2 = [timeStr rangeOfString:[NSString stringWithFormat:@"分"]];
        NSRange range3 = [timeStr rangeOfString:[NSString stringWithFormat:@"秒"]];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range1];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range2];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range3];
        [attStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xaaaaaa) range:range1];
        [attStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xaaaaaa) range:range2];
        [attStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xaaaaaa) range:range3];
        return attStr;
}
@end
