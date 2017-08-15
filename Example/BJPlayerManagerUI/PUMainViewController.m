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
#import <BJPlayerManagerCore/BJPlayerManagerCore.h>
#import <Masonry/Masonry.h>
#import "PUPlayViewController.h"
#import "PMDownloadViewController.h"

#import "UIAlertView+bjp.h"

@interface PUMainViewController ()
@property (strong, nonatomic) UISegmentedControl *deploySegment;
@property (strong, nonatomic) UITextField *vidTextField;
@property (strong, nonatomic) UITextField *tokenTextField;
@property (strong, nonatomic) UIButton *playButton;
@property (strong, nonatomic) UIButton *downloadBtn;
@property (strong, nonatomic) UILabel *adLabel;
//yes: 有片头片尾,另外还需要后台配置url才会有片头片尾, 如果没有配置, 就算adSwitch.on = yes, 也没有片头片尾
//no: 没有广告
@property (strong, nonatomic) UISwitch *adSwitch;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;

@end

@implementation PUMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupScrollView];
    
#if DEBUG
//    [self.contentView addSubview:self.deploySegment];
//    [self deploySegmentMakeConstraints];
#else
#endif
    [self.contentView addSubview:self.vidTextField];
    [self.contentView addSubview:self.tokenTextField];
    [self.contentView addSubview:self.adLabel];
    [self.contentView addSubview:self.adSwitch];
    [self.contentView addSubview:self.playButton];
    [self.contentView addSubview:self.downloadBtn];
    [self makeConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupScrollView
{
    self.contentView = [UIView new];
    self.scrollView = [UIScrollView new];
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.frame.size.height);
    
    [self.scrollView addSubview:self.contentView];
    [self.view addSubview:self.scrollView];
}

- (void)entryPlayControl
{
    NSString *vid = self.vidTextField.text;
    NSString *token = self.tokenTextField.text;
    BOOL isNeedAD = self.adSwitch.on;
    PUPlayViewController *playerVC = [[PUPlayViewController alloc] initWithVid:vid token:token isNeedAD:isNeedAD];
    [self.navigationController pushViewController:playerVC animated:YES];
}

- (void)downloadAction {
    PMDownloadViewController *downloadVC = [PMDownloadViewController new];
    [self.navigationController pushViewController:downloadVC animated:YES];
}

- (void)deployTypeChanged:(UISegmentedControl *)segment
{
#if DEBUG
    switch (segment.selectedSegmentIndex) {
        case 0:
            [PMAppConfig sharedInstance].deployType = PMDeployType_test;
            [self saveDeplayAndTipWithEnvType:0];
            break;
        case 1:
            [PMAppConfig sharedInstance].deployType = PMDeployType_beta;
            [self saveDeplayAndTipWithEnvType:1];
            break;
        case 2:
            [PMAppConfig sharedInstance].deployType = PMDeployType_www;
            [self saveDeplayAndTipWithEnvType:2];
            break;
        default:
            break;
    }
#else
#endif
}

#pragma mark - set get

- (UISegmentedControl *)deploySegment
{
    if (!_deploySegment) {
        _deploySegment = [[UISegmentedControl alloc] initWithItems:@[@"测试环境", @"Beta", @"线上"]];
        NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:@"developType"];
        _deploySegment.selectedSegmentIndex = index;
        [self setDevelopType:index];
        [_deploySegment addTarget:self action:@selector(deployTypeChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _deploySegment;
}
- (UITextField *)vidTextField
{
    if(!_vidTextField) {
        _vidTextField = [[UITextField alloc] init];
        _vidTextField.placeholder = @"vid";
        _vidTextField.text =  @"7029660";
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
        _tokenTextField.text = @"ncWQIhSEZ2k3S3PxCaNttVwQ5J9wa_7zH4RVoMI4fnGCk0tuSnPk-A";
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

- (UIButton *)downloadBtn
{
    if (!_downloadBtn) {
        _downloadBtn = [[UIButton alloc] init];
        _downloadBtn.backgroundColor = [UIColor redColor];
        _downloadBtn.layer.cornerRadius = 5.f;
        [_downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
        [_downloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_downloadBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
        [_downloadBtn addTarget:self action:@selector(downloadAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadBtn;
}

- (void)deploySegmentMakeConstraints
{
    [self.deploySegment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(20.f);
        make.right.equalTo(self.contentView).offset(-20.f);
        make.height.equalTo(@30);
    }];
}

- (void)makeConstraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(self.view);
        make.top.left.equalTo(self.scrollView);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.vidTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.equalTo(self.contentView).offset(30);
        make.right.equalTo(self.contentView).offset(-30);
        make.top.equalTo(self.contentView).offset(70);
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
    
    [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.right.equalTo(self.vidTextField);
        make.top.equalTo(self.playButton.mas_bottom).offset(30);
    }];
}

#pragma MARK - 切换环境
- (void)saveDeplayAndTipWithEnvType:(PMDeployType)type {
    [self saveDeplay:type];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"切换成功" message:@"必须重新启动app设置才生效" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"退出程序", nil];
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        abort();
    }];
}

- (void)saveDeplay:(PMDeployType)type {
    [[NSUserDefaults standardUserDefaults] setInteger:type forKey:@"developType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setDevelopType:(NSInteger)type {
    
#if DEBUG
    switch (type) {
        case 0:
            [PMAppConfig sharedInstance].deployType = PMDeployType_test;
            break;
            
        case 1:
            [PMAppConfig sharedInstance].deployType = PMDeployType_beta;
            break;
            
        case 2:
            [PMAppConfig sharedInstance].deployType = PMDeployType_www;
            break;
            
        default:
            break;
    }
#else
#endif
}

@end
