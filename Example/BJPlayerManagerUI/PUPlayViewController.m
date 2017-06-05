//
//  PUPlayViewController.m
//  BJHL-VideoPlayer-UI
//
//  Created by DLM on 2017/4/26.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "PUPlayViewController.h"
#import <BJPlayerManagerUI/BJPlayerManagerUI.h>
#import <BJPlayerManagerUI/BJPUMacro.h>

@interface PUPlayViewController ()
@property (strong, nonatomic) NSString *vid;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *token;

@property (strong, nonatomic) BJPUViewController *playerUIVC;
@end

@implementation PUPlayViewController

- (instancetype)initWithVid:(NSString *)vid type:(NSString *)type token:(NSString *)token
{
    self = [super init];
    if (self) {
        _vid = vid;
        _type = type;
        _token = token;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.playerUIVC = [[BJPUViewController alloc] init];
    [self.playerUIVC setSmallScreenFrame:CGRectMake(0, 64, BJPUScreenWidth, BJPUScreenWidth*9/16)];
    [self.view addSubview:self.playerUIVC.view];
    [self addChildViewController:self.playerUIVC];
    [self.playerUIVC playWithVid:_vid type:_type token:_token];
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

@end
