//
//  CMCountDownLabel.h
//  DateHelper
//
//  Created by song.he on 15/6/23.
//  Copyright (c) 2015年 song.he. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCountDownLabel : UILabel

@property (assign,readonly) BOOL counting;

@property (copy) void (^endedBlock)(NSTimeInterval);

-(void)startWithEndingBlock:(void(^)(NSTimeInterval countTime))end;
-(void)setCountDownTime:(NSTimeInterval)time;

-(void)start;

@end
