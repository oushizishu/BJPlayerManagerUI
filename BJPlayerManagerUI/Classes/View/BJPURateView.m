//
//  BJPURateView.m
//  Pods,设置倍速view
//
//  Created by DLM on 2017/4/27.
//
//

#import "BJPURateView.h"
#import "BJPUTheme.h"

@interface BJPURateView ()
@property (strong, nonatomic) UIButton *rateButton0;
@property (strong, nonatomic) UIButton *rateButton1;
@property (strong, nonatomic) UIButton *rateButton2;

@end

@implementation BJPURateView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [[BJPUTheme brandColor] colorWithAlphaComponent:0.5];
        [self addSubview:self.rateButton0];
        [self addSubview:self.rateButton1];
        [self addSubview:self.rateButton2];
        [self.rateButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.offset(0);
            make.width.mas_equalTo(50.f);
            make.height.mas_equalTo(20.f);
        }];
        [self.rateButton0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.bottom.equalTo(self.rateButton1.mas_top).offset(-20.f);
            make.width.height.equalTo(self.rateButton1);
        }];
        [self.rateButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(self.rateButton1.mas_bottom).offset(20.f);
            make.width.height.equalTo(self.rateButton1);
        }];
    }
    return self;
}

#pragma mark - action
- (void)changeRateAction:(UIButton *)button
{
    if ([button isEqual:self.rateButton0]) {
        self.rate = 1.f;
    }
    else if ([button isEqual:self.rateButton1]) {
        self.rate = 1.5f;
    }
    else if ([button isEqual:self.rateButton2]) {
        self.rate = 2.f;
    }
    [self.delegate rateView:self changeRate:self.rate];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1 animations:^{
        __strong typeof(weakSelf) self = weakSelf;
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) self = weakSelf;
        self.hidden = true;
        self.alpha = 1.f;
    }];
}

#pragma mark - set get
- (void)setRate:(CGFloat)rate
{
    _rate = rate;
    if (rate > 0.9 && rate < 1.1) {
        [_rateButton0 BJPURateViewSetSelected:true];
        [_rateButton1 BJPURateViewSetSelected:false];
        [_rateButton2 BJPURateViewSetSelected:false];
    }
    else if (rate > 1.4 && rate < 1.6) {
        [_rateButton0 BJPURateViewSetSelected:false];
        [_rateButton1 BJPURateViewSetSelected:true];
        [_rateButton2 BJPURateViewSetSelected:false];
    }
    else if (rate > 1.9 && rate < 2.1) {
        [_rateButton0 BJPURateViewSetSelected:false];
        [_rateButton1 BJPURateViewSetSelected:false];
        [_rateButton2 BJPURateViewSetSelected:true];
    }
}

- (UIButton *)rateButton0
{
    if (!_rateButton0) {
        _rateButton0 = [[UIButton alloc] init];
        [_rateButton0 setTitle:@"1.0x" forState:UIControlStateNormal];
        [_rateButton0.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _rateButton0.layer.cornerRadius = 10.f;
        _rateButton0.layer.borderColor = [BJPUTheme highlightTextColor].CGColor;
        _rateButton0.layer.borderWidth = 1.f;
        [_rateButton0 addTarget:self action:@selector(changeRateAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rateButton0 setTitleColor:[BJPUTheme highlightTextColor] forState:UIControlStateNormal];
    }
    return _rateButton0;
}
- (UIButton *)rateButton1
{
    if (!_rateButton1) {
        _rateButton1 = [[UIButton alloc] init];
        [_rateButton1 setTitle:@"1.5x" forState:UIControlStateNormal];
        [_rateButton1.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_rateButton1 setTitleColor:[BJPUTheme defaultTextColor] forState:UIControlStateNormal];
        _rateButton1.layer.cornerRadius = 10.f;
        _rateButton1.layer.borderColor = [BJPUTheme defaultTextColor].CGColor;
        _rateButton1.layer.borderWidth = 1.f;
        [_rateButton1 addTarget:self action:@selector(changeRateAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rateButton1;
}
- (UIButton *)rateButton2
{
    if (!_rateButton2) {
        _rateButton2 = [[UIButton alloc] init];
        [_rateButton2 setTitle:@"2.0x" forState:UIControlStateNormal];
        [_rateButton2.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_rateButton2 setTitleColor:[BJPUTheme defaultTextColor] forState:UIControlStateNormal];
        _rateButton2.layer.cornerRadius = 10.f;
        _rateButton2.layer.borderColor = [BJPUTheme defaultTextColor].CGColor;
        _rateButton2.layer.borderWidth = 1.f;
        [_rateButton2 addTarget:self action:@selector(changeRateAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rateButton2;
}
@end


@implementation UIButton (BJPURateView)

- (void)BJPURateViewSetSelected:(BOOL)selected
{
    if (selected) {
        [self setTitleColor:[BJPUTheme highlightTextColor] forState:UIControlStateNormal];
        self.layer.borderColor = [BJPUTheme highlightTextColor].CGColor;
    } else {
        [self setTitleColor:[BJPUTheme defaultTextColor] forState:UIControlStateNormal];
        self.layer.borderColor = [BJPUTheme defaultTextColor].CGColor;
    }
}

@end
