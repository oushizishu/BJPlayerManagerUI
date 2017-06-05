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
    self.sliderBgView = [[UIView alloc] initWithFrame:CGRectMake(0, y, frame.size.width, slider_height)];
    self.sliderBgView.layer.masksToBounds = YES;
    self.sliderBgView.layer.cornerRadius = slider_height / 2;
    
    self.slider = [[BJPUVideoSlider alloc] initWithFrame:CGRectMake(0, slider_y, frame.size.width, frame.size.height)];
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
    
    
    self.cacheView = [[UIView alloc] initWithFrame:CGRectMake(2, 0, 0, slider_height)];
    self.cacheView.layer.masksToBounds = YES;
    self.cacheView.layer.cornerRadius = 1;
    self.cacheView.backgroundColor = [UIColor whiteColor];
    
    self.progressView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, slider_height)];
    self.progressView.layer.masksToBounds = YES;
    self.progressView.image = leftStretch;
    
    self.durationView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 0, frame.size.width - 2, slider_height)];
    self.durationView.center = self.slider.center;
    self.durationView.layer.cornerRadius = 1;
    self.durationView.layer.masksToBounds = YES;
    self.durationView.image = rightStretch;
    
    [self.sliderBgView addSubview:self.durationView];
    [self.sliderBgView addSubview:self.cacheView];
    [self.sliderBgView addSubview:self.progressView];
    
    [self addSubview:self.sliderBgView];
    [self addSubview:self.slider];
    
    [self setValue:0 cache:0 duration:0];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.slider.frame = CGRectMake(0, self.slider.frame.origin.y, frame.size.width, self.slider.frame.size.height);
    self.sliderBgView.frame = CGRectMake(0, self.sliderBgView.frame.origin.y, frame.size.width, self.sliderBgView.frame.size.height);
    self.durationView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

-(void)setValue:(float)value cache:(float)cache duration:(float)duration
{
    self.slider.value = value;
    self.slider.maximumValue = duration;
    if (duration == 0.0)
    {
        self.progressView.frame = CGRectMake(0, 0, 0, self.frame.size.height);
        self.cacheView.frame = CGRectMake(0, 0, 0, self.cacheView.frame.size.height);
    }
    else
    {
        self.progressView.frame = CGRectMake(0, 0, (value / duration) * (self.frame.size.width), self.frame.size.height);
        self.cacheView.frame = CGRectMake(2, 0, (cache / duration) * (self.frame.size.width) - 4, self.cacheView.frame.size.height);
    }
    self.durationView.frame = CGRectMake(2, 0, self.durationView.frame.size.width, self.durationView.frame.size.height);
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
