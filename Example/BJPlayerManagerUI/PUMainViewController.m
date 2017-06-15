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
#import "PUPlayViewController.h"

@interface PUMainViewController ()
@property (strong, nonatomic) UITextField *vidTextField;
@property (strong, nonatomic) UITextField *tokenTextField;
@property (strong, nonatomic) UIButton *playButton;
@end

@implementation PUMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.vidTextField];
    [self.view addSubview:self.tokenTextField];
    [self.view addSubview:self.playButton];
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
    PUPlayViewController *playerVC = [[PUPlayViewController alloc] initWithVid:vid token:token];
    [self.navigationController pushViewController:playerVC animated:YES];
}


#pragma mark - set get
- (UITextField *)vidTextField
{
    if(!_vidTextField) {
        _vidTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, BJPUScreenWidth - 40, 30)];
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
        _tokenTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 180, BJPUScreenWidth - 40, 30)];
        _tokenTextField.placeholder = @"token";
        _tokenTextField.text = @"_bxXjD0HrF43S3PxCaNttR0QDPLIrj5HHFoJA-fpZQuqnE4eIe0_Hg";
        _tokenTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _tokenTextField.layer.borderWidth = 0.5;
        _tokenTextField.layer.cornerRadius = 5.f;
    }
    return _tokenTextField;
}


- (UIButton *)playButton
{
    if (!_playButton) {
        _playButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 240, BJPUScreenWidth-40, 30)];
        _playButton.backgroundColor = [UIColor redColor];
        _playButton.layer.cornerRadius = 5.f;
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        [_playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_playButton.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
        [_playButton addTarget:self action:@selector(entryPlayControl) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}
@end
