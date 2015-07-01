//
//  CMLimitPriceAlertView.h
//  Choumeimeifa
//
//  Created by hesong on 15/6/24.
//  Copyright (c) 2015年 xiaokang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CMRushToPurchase)();

@interface CMLimitPriceAlertView : UIView

@property (nonatomic,copy)CMRushToPurchase rushToPurchase;

- (void)show;

@end
