//
//  PMLocalViewViewController.m
//  BJPlayerManagerCore
//
//  Created by 辛亚鹏 on 2017/6/19.
//  Copyright © 2017年 oushizishu. All rights reserved.
//

#import <BJPlayerManagerUI/BJPlayerManagerUI.h>

#import "PMLocalViewViewController.h"

@interface PMLocalViewViewController ()

@property (strong, nonatomic) BJPUViewController *playerUIVC;
@property (strong, nonatomic) NSString *path;
@property (assign, nonatomic) NSInteger type;

@end

@implementation PMLocalViewViewController

- (instancetype)initWithPath:(NSString *)path definitionType:(NSInteger)type {
    if (self = [super init]) {
        _path = path;
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    self.playerUIVC = [[BJPUViewController alloc] init];
    [self.playerUIVC setSmallScreenFrame:CGRectMake(0, 64, BJPUScreenWidth, BJPUScreenWidth*9/16)];
    [self.view addSubview:self.playerUIVC.view];
    UIInterfaceOrientation orirentaion = [[UIApplication sharedApplication] statusBarOrientation];
    if (orirentaion == UIDeviceOrientationLandscapeLeft
        || orirentaion == UIDeviceOrientationLandscapeRight) {
        [self.playerUIVC setScreenType:BJPUScreenType_Full];
        self.navigationController.navigationBarHidden = YES;
    }
    
    [self.playerUIVC playWithVideoPath:self.path definitionType:self.type];
    [self addChildViewController:self.playerUIVC];
    
}

@end
