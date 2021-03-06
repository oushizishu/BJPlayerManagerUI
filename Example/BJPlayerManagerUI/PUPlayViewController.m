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
#import <BJPlayerManagerCore/BJPlayerManagerCore.h>

@interface PUPlayViewController ()
@property (strong, nonatomic) NSString *vid;
@property (strong, nonatomic) NSString *token;
@property (assign, nonatomic) BOOL isNeedAD, mayDrag;

@property (strong, nonatomic) BJPUViewController *playerUIVC;
@end

@implementation PUPlayViewController

- (instancetype)initWithVid:(NSString *)vid token:(NSString *)token isNeedAD:(BOOL)isNeedAD mayDrag:(BOOL)mayDrag
{
    self = [super init];
    if (self) {
        _vid = vid;
        _token = token;
        _isNeedAD = isNeedAD;
        _mayDrag = mayDrag;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [PMAppConfig sharedInstance].isNeedAD = self.isNeedAD;
    self.playerUIVC = [[BJPUViewController alloc] init];
    [self.playerUIVC sliderMayDrag:self.mayDrag];
    [self.playerUIVC setSmallScreenFrame:CGRectMake(0, 64, BJPUScreenWidth, BJPUScreenWidth*9/16)];
    [self.view addSubview:self.playerUIVC.view];
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        [self.playerUIVC setScreenType:BJPUScreenType_Full];
        self.navigationController.navigationBarHidden = YES;
    }
    [self addChildViewController:self.playerUIVC];
    [self.playerUIVC playWithVid:_vid token:_token];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
