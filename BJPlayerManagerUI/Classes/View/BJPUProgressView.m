//
//  BJPUProgressView.m
//  Pods
//
//  Created by DLM on 2017/4/26.
//
//

#import "BJPUProgressView.h"
#import "BJPUAppearance.h"

@interface BJPUProgressView ()
@property (nonatomic, strong) UIView *sliderBgView;
@property (nonatomic, strong) UIView *cacheView;
@property (nonatomic, strong) UIImageView *progressView;
@property (nonatomic, strong) UIImageView *durationView;

@end

@implementation BJPUProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self loadView:frame];
    }
    return self;
}

- (void)dealloc
{
    self.sliderBgView = nil;
    self.slider = nil;
    self.cacheView = nil;
    self.progressView = nil;
}

- (void)loadView:(CGRect)frame
{
    NSInteger y = 0;
    NSInteger slider_y = -8;
    NSInteger slider_height = 10;
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>= 7.0)
    {
        y = 4;
        slider_y = 0;
        slider_height = frame.size.height - 2 *y;
    }
    self.sliderBgView = [[UIView alloc] init];
    self.sliderBgView.layer.masksToBounds = YES;
    self.sliderBgView.layer.cornerRadius = slider_height / 2;
    
    self.slider = [[BJPUVideoSlider alloc] init];
    
    self.slider.backgroundColor = [UIColor clearColor];
    self.slider.minimumTrackTintColor = [UIColor clearColor];
    self.slider.maximumTrackTintColor = [UIColor clearColor];
    
    UIImage *leftStretch = [[UIImage bjpu_imageNamed:@"ic_player_progress_orange_n.png"]
                            stretchableImageWithLeftCapWidth:4.0
                            topCapHeight:1.0];
    UIImage *rightStretch = [[UIImage bjpu_imageNamed:@"ic_player_progress_gray_n.png"]
                             stretchableImageWithLeftCapWidth:4.0
                             topCapHeight:1.0];
    
    // iOS 8 以下用自定义的
    if ([[UIDevice currentDevice].systemVersion floatValue]>= 8.0)
    {
        [self.slider setMinimumTrackImage:leftStretch forState:UIControlStateNormal];
    }
    //    [self.slider setMaximumTrackImage:rightStretch forState:UIControlStateNormal];
    [self.slider setThumbImage:[UIImage bjpu_imageNamed:@"ic_player_current_n.png"] forState:UIControlStateNormal];
    [self.slider setThumbImage:[UIImage bjpu_imageNamed:@"ic_player_current_big_n.png"] forState:UIControlStateHighlighted];
    
    
//    self.cacheView = [[UIView alloc] initWithFrame:CGRectMake(2, 0, 0, slider_height)];
    self.cacheView = [[UIView alloc] init];
    
    self.cacheView.layer.masksToBounds = YES;
    self.cacheView.layer.cornerRadius = 1;
    self.cacheView.backgroundColor = [UIColor whiteColor];
    
//    self.progressView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, slider_height)];
    self.progressView = [[UIImageView alloc] init];
    
    self.progressView.layer.masksToBounds = YES;
    self.progressView.image = leftStretch;
    
//    self.durationView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 0, frame.size.width - 2, slider_height)];
    self.durationView = [[UIImageView alloc] init];
                         
    self.durationView.center = self.slider.center;
    self.durationView.layer.cornerRadius = 1;
    self.durationView.layer.masksToBounds = YES;
    self.durationView.image = rightStretch;
    
    [self.sliderBgView addSubview:self.durationView];
    [self.sliderBgView addSubview:self.cacheView];
    [self.sliderBgView addSubview:self.progressView];
    
    [self addSubview:self.sliderBgView];
    [self addSubview:self.slider];
    
    [self makeConstraints];
    
    [self setValue:0 cache:0 duration:0];
}

- (void)makeConstraints {
    [self.sliderBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.centerY.offset(0);
        make.width.mas_equalTo(self.frame.size.width);
        make.height.mas_equalTo(self.frame.size.height-8);
    }];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.centerY.equalTo(self.sliderBgView).offset(-1);
        make.width.equalTo(self.sliderBgView);
        make.height.mas_equalTo(self.frame.size.height);
    }];

    [self.cacheView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(2);
        make.centerY.offset(0);
        make.width.mas_equalTo(0);
        make.height.equalTo(self.sliderBgView);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.centerY.offset(0);
        make.width.mas_equalTo(0);
        make.height.equalTo(self.sliderBgView);
    }];
    
    [self.durationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(2.f);
        make.top.offset(0);
        make.width.mas_equalTo(self.frame.size.width-2);
        make.height.equalTo(self.sliderBgView);
    }];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.slider mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.mas_equalTo(self.frame.size.width);
        make.height.mas_equalTo(self.frame.size.height-8);
    }];
    [self.sliderBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
//        make.top.offset(4.f);
        make.width.mas_equalTo(self.frame.size.width);
        make.height.mas_equalTo(self.frame.size.height-8);
    }];
    [self.durationView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.mas_equalTo(self.frame.size.width);
        make.height.mas_equalTo(self.frame.size.height-8);
    }];
}

-(void)setValue:(float)value cache:(float)cache duration:(float)duration
{
    self.slider.value = value;
    self.slider.maximumValue = duration;
    if (duration == 0.0)
    {
        [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(0);
            make.width.mas_equalTo(0);
            make.height.mas_equalTo(self.frame.size.height);
        }];
        [self.cacheView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.centerY.offset(0);
            make.width.mas_equalTo(0);
            make.height.mas_equalTo(self.frame.size.height-8);
        }];
    }
    else
    {
        [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(value / duration);
        }];
        [self.cacheView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo((cache / duration) * (self.frame.size.width));
        }];
        
    }
    [self.durationView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset(2.f);
        make.top.offset(0);
    }];
}
@end


@implementation BJPUVideoSlider

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    rect.origin.x = rect.origin.x - 2 ;
    rect.size.width = rect.size.width + 4;
    CGRect thumbRect = [super thumbRectForBounds:bounds trackRect:rect value:value];
    if (self.maximumValue > 0)
    {
        thumbRect.origin.x = value / self.maximumValue * self.bounds.size.width - self.currentThumbImage.size.width / 2;
    }
    return thumbRect;
}

- (CGRect)minimumValueImageRectForBounds:(CGRect)bounds
{
    return CGRectZero;
}

- (CGRect)maximumValueImageRectForBounds:(CGRect)bounds
{
    return CGRectZero;
}

@end
