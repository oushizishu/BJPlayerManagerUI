//
//  BJPUFullBottomView.m
//  Pods
//
//  Created by DLM on 2017/4/27.
//
//

#import "BJPUFullBottomView.h"
#import "BJPUTheme.h"

@implementation BJPUFullBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.playButton];
        [self addSubview:self.pauseButton];
        [self addSubview:self.nextVideoButton];
        [self addSubview:self.relTimeLabel];
        [self addSubview:self.durationLabel];
        [self addSubview:self.progressView];
        [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.offset(10.f);
            make.centerY.offset(0);
            make.width.height.mas_equalTo(30.f);
        }];
        [self.pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.playButton);
        }];
        [self.nextVideoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.playButton.mas_trailing).offset(10.f);
            make.centerY.offset(0);
            make.width.height.mas_equalTo(30.f);
        }];
        [self.relTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.nextVideoButton.mas_trailing).offset(10.f);
            make.centerY.offset(0);
        }];
        [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.offset(-10.f);
            make.centerY.offset(0);
        }];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat x = self.relTimeLabel.frame.origin.x + self.relTimeLabel.frame.size.width + 20;
    CGFloat width = self.durationLabel.frame.origin.x - 20 - x;
    self.progressView.frame = CGRectMake(x, 15, width, 10);
}

#pragma mark - set get
- (UIButton *)playButton
{
    if (!_playButton)
    {
        _playButton = [UIButton new];
        [_playButton setImage:[BJPUTheme playButtonImage] forState:UIControlStateNormal];
    }
    return _playButton;
}
- (UIButton *)pauseButton
{
    if (!_pauseButton)
    {
        _pauseButton = [UIButton new];
        _pauseButton.hidden = YES;
        [_pauseButton setImage:[BJPUTheme pauseButtonImage] forState:UIControlStateNormal];
    }
    return _pauseButton;
}
- (UIButton *)nextVideoButton
{
    if (!_nextVideoButton)
    {
        _nextVideoButton = [UIButton new];
        [_nextVideoButton setImage:[BJPUTheme nextButtonImage] forState:UIControlStateNormal];
    }
    return _nextVideoButton;
}
- (BJPUProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[BJPUProgressView alloc] initWithFrame:CGRectMake(-100, 20, 100, 10)];
    }
    return _progressView;
}
- (UILabel *)relTimeLabel
{
    if (!_relTimeLabel)
    {
        _relTimeLabel = [UILabel new];
        _relTimeLabel.text = @"00:00";
        _relTimeLabel.textColor = [BJPUTheme defaultTextColor];
        _relTimeLabel.font = [UIFont systemFontOfSize:10];
    }
    return _relTimeLabel;
}
- (UILabel *)durationLabel
{
    if (!_durationLabel) {
        _durationLabel = [UILabel new];
        _durationLabel.textColor = [BJPUTheme defaultTextColor];
        _durationLabel.font = [UIFont systemFontOfSize:10];
    }
    return _durationLabel;
}

@end
