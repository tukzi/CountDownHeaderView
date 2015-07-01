//
//  CMTimeModel.m
//  DateHelper
//
//  Created by song.he on 15/6/24.
//  Copyright (c) 2015年 song.he. All rights reserved.
//

#import "CMTimeModel.h"

@implementation CMTimeModel

- (void)setAttributes:(NSDictionary*)dataDic{
    [super setAttributes:dataDic];
    
    if ([_currentDate doubleValue] < [_startDate doubleValue]) {
        //未开始
        _timerType = CMTimerLabelTypeUnStart;
        
    }else if ([_currentDate doubleValue] >= [_startDate doubleValue] && [_currentDate doubleValue] <= [_endDate doubleValue]){
        //进行中
        _timerType = CMTimerLabelTypeStarting;
    }else {
        //结束
        _timerType = CMTimerLabelTypeEnd;
        
    }
    
}



@end
