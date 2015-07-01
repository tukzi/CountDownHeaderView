//
//  CMLimitPriceAlertView.m
//  Choumeimeifa
//
//  Created by hesong on 15/6/24.
//  Copyright (c) 2015年 xiaokang. All rights reserved.
//

#import "CMLimitPriceAlertView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//颜色
#define Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)//屏高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)//屏宽

#define BgViewWeight 265
#define BgViewHeight 320

@interface CMLimitPriceAlertView ()

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *lineImageView;
@property(nonatomic,strong)UIImageView *signImageView;
@property(nonatomic,strong)UIImageView *logoImageView;

@property(nonatomic,strong)UILabel *strLabel;

@property(nonatomic,strong)UIButton *purchaseBtn;
@property(nonatomic,strong)UIButton *closeBtn;

@end

@implementation CMLimitPriceAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)_initView{
    self.backgroundColor = Color(0, 0, 0, 0.5);

    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BgViewWeight, BgViewHeight)];
    _bgView.center = self.center;
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 5;
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, BgViewWeight, 40)];
    _titleLabel.text = @"抢购信息";
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_titleLabel];
    
    _lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), BgViewWeight, 0.5)];
    _lineImageView.backgroundColor = UIColorFromRGB(0xaaaaaa);
    [_bgView addSubview:_lineImageView];
    
    _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(BgViewWeight/2 - 100/2, CGRectGetMaxY(_lineImageView.frame) + 20, 100, 100)];
    _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _logoImageView.image = [UIImage imageNamed:@"qiangouxinxi_icon"];
    [_bgView addSubview:_logoImageView];
    
    _signImageView = [[UIImageView alloc]initWithFrame:CGRectMake(35, CGRectGetMaxY(_logoImageView.frame) + 20, BgViewWeight - 85, 15)];
    _signImageView.contentMode = UIViewContentModeScaleAspectFill;
    _signImageView.image = [UIImage imageNamed:@"qiangouxinxi_wenzi"];
    [_bgView addSubview:_signImageView];
    
    _strLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_signImageView.frame) + 10, BgViewWeight, 20)];
    _strLabel.text = @"每份最多售5个，手慢有手慢无！";
    _strLabel.font = [UIFont systemFontOfSize:14];
    _strLabel.textColor = [UIColor grayColor];
    _strLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_strLabel];
    

    _purchaseBtn = [[UIButton alloc] initWithFrame:CGRectMake(44,CGRectGetMaxY(_strLabel.frame) + 15,  BgViewWeight - 88, 50)];
    _purchaseBtn.backgroundColor = [UIColor redColor];
    [_purchaseBtn setTitle:@"去抢购！" forState:UIControlStateNormal];
    [_purchaseBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_purchaseBtn setTypeGrayWord];
    [_bgView addSubview:_purchaseBtn];
    
    _closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(BgViewWeight - 40/2, -10, 30, 30)];
    [_closeBtn setImage:[UIImage imageNamed:@"xstjtc_guanbi_button_normal"] forState:UIControlStateNormal];
    [_closeBtn setImage:[UIImage imageNamed:@"xstjtc_guanbi_button_pressed"] forState:UIControlStateHighlighted];
    [_closeBtn addTarget:self action:@selector(closeAlert) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_closeBtn];
    

}

#pragma mark - Actions

//关闭
- (void)closeAlert{
    [self dismissWithAnimation];
}

//去抢购
- (void)btnClick{
    [self closeAlert];
    !_rushToPurchase ? :_rushToPurchase();
}

#pragma mark - show and dismiss

- (void)show {
 
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    [self addSubview:_bgView];
    [self showAnimation];
}

- (void)showAnimation {
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_bgView.layer addAnimation:popAnimation forKey:nil];

}

- (void)dismissWithAnimation{
    
    [UIView animateWithDuration:0.4 animations:^{
        _bgView.alpha = 0.0;
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    

}

@end
