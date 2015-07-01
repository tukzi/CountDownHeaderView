//
//  CMTimeModel.h
//  DateHelper
//
//  Created by song.he on 15/6/24.
//  Copyright (c) 2015年 song.he. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMFatory.h"

typedef enum{
    CMTimerLabelTypeUnStart,
    CMTimerLabelTypeStarting,
    CMTimerLabelTypeEnd
}CMTimerLabelType;

@interface CMTimeModel : CMFatory

@property(nonatomic,strong)NSString *currentDate;
@property(nonatomic,strong)NSString *startDate;
@property(nonatomic,strong)NSString *endDate;

@property(nonatomic,strong)NSString *hintStr;

@property (assign) CMTimerLabelType timerType;

@end
