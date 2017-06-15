//
//  PUMainViewController.m
//  BJHL-VideoPlayer-UI
//
//  Created by DLM on 2017/4/26.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "PUMainViewController.h"
#import <BJPlayerManagerUI/BJPlayerManagerUI.h>
#import <BJPlayerManagerUI/BJPUMacro.h>
#import <Masonry/Masonry.h>
#import "PUPlayViewController.h"

@interface PUMainViewController ()
@property (strong, nonatomic) UITextField *vidTextField;
@property (strong, nonatomic) UITextField *tokenTextField;
@property (strong, nonatomic) UIButton *playButton;
@property (strong, nonatomic) UILabel *adLabel;
//yes: 有片头片尾,另外还需要后台配置url才会有片头片尾, 如果没有配置, 就算adSwitch.on = yes, 也没有片头片尾
//no: 没有广告
@property (strong, nonatomic) UISwitch *adSwitch;
@end

@implementation PUMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.vidTextField];
    [self.view addSubview:self.tokenTextField];
    [self.view addSubview:self.adLabel];
    [self.view addSubview:self.adSwitch];
    [self.view addSubview:self.playButton];
    [self makeConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)entryPlayControl
{
    NSString *vid = self.vidTextField.text;
    NSString *token = self.tokenTextField.text;
    BOOL isNeedAD = self.adSwitch.on;
    PUPlayViewController *playerVC = [[PUPlayViewController alloc] initWithVid:vid token:token isNeedAD:isNeedAD];
    [self.navigationController pushViewController:playerVC animated:YES];
}


#pragma mark - set get
- (UITextField *)vidTextField
{
    if(!_vidTextField) {
        _vidTextField = [[UITextField alloc] init];
        _vidTextField.placeholder = @"vid";
        _vidTextField.text = @"6675459";
        _vidTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _vidTextField.layer.borderWidth = 0.5;
        _vidTextField.layer.cornerRadius = 5.f;
    }
    return _vidTextField;
}

- (UITextField *)tokenTextField
{
    if(!_tokenTextField) {
        _tokenTextField = [[UITextField alloc] init];
        _tokenTextField.placeholder = @"token";
        _tokenTextField.text = @"_bxXjD0HrF43S3PxCaNttR0QDPLIrj5HHFoJA-fpZQuqnE4eIe0_Hg";
        _tokenTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _tokenTextField.layer.borderWidth = 0.5;
        _tokenTextField.layer.cornerRadius = 5.f;
    }
    return _tokenTextField;
}

- (UILabel *)adLabel {
    if (!_adLabel) {
        _adLabel = [UILabel new];
        _adLabel.text = @"是否有片头片尾广告: ";
        _adLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _adLabel.layer.borderWidth = 0.5;
    }
    return _adLabel;
}

- (UISwitch *)adSwitch {
    if (!_adSwitch) {
        _adSwitch = [[UISwitch alloc] init];
    }
    return _adSwitch;
}

- (UIButton *)playButton
{
    if (!_playButton) {
        _playButton = [[UIButton alloc] init];
        _playButton.backgroundColor = [UIColor redColor];
        _playButton.layer.cornerRadius = 5.f;
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        [_playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_playButton.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
        [_playButton addTarget:self action:@selector(entryPlayControl) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (void)makeConstraints {
    [self.vidTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.top.equalTo(self.view).offset(100);
    }];
    
    [self.tokenTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.right.equalTo(self.vidTextField);
        make.top.equalTo(self.vidTextField.mas_bottom).offset(30);
    }];
    
    [self.adLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vidTextField);
        make.height.equalTo(@30);
        make.width.equalTo(@180);
        make.top.equalTo(self.tokenTextField.mas_bottom).offset(30);
    }];
    
    [self.adSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.adLabel.mas_right).offset(20);
        make.top.bottom.equalTo(self.adLabel);
    }];
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.right.equalTo(self.vidTextField);
        make.top.equalTo(self.adLabel.mas_bottom).offset(30);
    }];
}
@end
