//
//  BJPUViewController.m
//  Pods
//
//  Created by DLM on 2017/4/26.
//
//

#import "BJPUViewController.h"
#import "BJPUFullViewController.h"
#import "BJPUSmallViewController.h"
#import "BJPUMacro.h"
#import <BJPlayerManagerCore/BJPlayerManagerCore.h>

@interface BJPUViewController () <BJPUViewControllerProtocol, BJPMProtocol>

@property (strong, nonatomic) BJPUSmallViewController *smallVC;
@property (strong, nonatomic) BJPUFullViewController *fullVC;
@property (strong, nonatomic) BJPlayerManager *playerManager;

@property (assign, nonatomic) BOOL isNavigationBarHidden;
@property (strong, nonatomic) NSTimer *updateDurationTimer;

@end

@implementation BJPUViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubviews];
    self.screenType = BJPUScreenType_Small;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerPlayStateChanged:)
                                                 name:PMPlayStateChangeNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.updateDurationTimer invalidate];
    self.updateDurationTimer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubviews
{
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.playerManager.player.view];
    [self.view addSubview:self.fullVC.view];
    [self.view addSubview:self.smallVC.view];
    
    [self.playerManager.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    [self.fullVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    [self.smallVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

#pragma mark - process notification
- (void)deviceOrientationDidChange:(NSNotification *)noti
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight || [self.fullVC isLocked]) {
        NSLog(@"横屏模式");
        _isNavigationBarHidden = self.navigationController.isNavigationBarHidden;
        self.navigationController.navigationBarHidden = YES;
        self.screenType = BJPUScreenType_Full;
    }
    else if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {
        NSLog(@"竖屏模式");
        [self.navigationController setNavigationBarHidden:_isNavigationBarHidden];
        self.screenType = BJPUScreenType_Small;
    }
}

- (void)playerPlayStateChanged:(NSNotification *)noti
{
    BJPlayerManager *playerManager = (BJPlayerManager*)noti.object;
    [self.smallVC updatePlayState:playerManager.playState];
    [self.fullVC updatePlayState:playerManager.playState];
    
    if (playerManager.playState == PMPlayStatePlaying
        && playerManager.player.runingPlayer == PKMovieNormalPlayer) {
        if (!self.updateDurationTimer || ![self.updateDurationTimer isValid]) {
            self.updateDurationTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self
                                                                      selector:@selector(updatePlayTime)
                                                                      userInfo:nil repeats:true];
        }
    }
    else {
        [self.updateDurationTimer invalidate];
        self.updateDurationTimer = nil;
    }
}

- (void)updatePlayTime
{
    long curr = _playerManager.currentTime;
    long cache = _playerManager.cacheDuration;
    long total = _playerManager.duration;
    [self.smallVC updateCurrentPlayDuration:curr playableDuration:cache totalDuration:total];
    [self.fullVC updateCurrentPlayDuration:curr playableDuration:cache totalDuration:total];
}

#pragma mark - public interface
- (void)playWithVid:(NSString *)vid token:(NSString *)token
{
    [self.playerManager setVideoID:vid token:token];
}

- (void)playWithVideoPath:(NSString *)path definitionType:(NSInteger)definitionType
{
    [self.playerManager setVideoPath:path definition:definitionType];
}

#pragma mark - BJPUViewControllerProtocol
- (void)changeScreenType:(BJPUScreenType)type
{
    if (type == BJPUScreenType_Small) {
        [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
    }
    else if (type == BJPUScreenType_Full) {
        [[UIDevice currentDevice] setValue:@(UIDeviceOrientationLandscapeLeft) forKey:@"orientation"];
    }
}

#pragma mark - BJPMProtocol
- (void)videoplayer:(BJPlayerManager *)playerManager throwPlayError:(NSError *)error
{
    if (error.code == BJPMErrorCodeLoading) {
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    } else if (BJPMErrorCodeLoadingEnd == error.code) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    } else if (BJPMErrorCodeParse == error.code) {
        
    } else if (BJPMErrorCodeNetwork == error.code) {
        
    } else if (BJPMErrorCodeWWAN == error.code) {
        
    } else if (BJPMErrorCodeServer == error.code) {
        
    }
}

#pragma mark - set get
- (void)setScreenType:(BJPUScreenType)screenType
{
    _screenType = screenType;
    if (screenType == BJPUScreenType_Full) {
        self.smallVC.view.hidden = true;
        self.fullVC.view.hidden = false;
        self.navigationController.navigationBarHidden = true;
        self.view.frame = CGRectMake(0, 0, BJPUScreenHeight, BJPUScreenWidth);
    } else if (screenType == BJPUScreenType_Small) {
        self.smallVC.view.hidden = false;
        self.fullVC.view.hidden = true;
        self.view.frame = self.smallScreenFrame;
    }
}

- (BJPlayerManager *)playerManager
{
    if (!_playerManager) {
        _playerManager = [[BJPlayerManager alloc] init];
        _playerManager.delegate = self;
    }
    return _playerManager;
}

- (BJPUSmallViewController *)smallVC
{
    if (!_smallVC) {
        _smallVC = [[BJPUSmallViewController alloc] initWithPlayerManager:self.playerManager];
        _smallVC.delegate = self;
        [self addChildViewController:_smallVC];
    }
    return _smallVC;
}

- (BJPUFullViewController *)fullVC
{
    if (!_fullVC) {
        _fullVC = [[BJPUFullViewController alloc] initWithPlayerManager:self.playerManager];
        _fullVC.delegate = self;
        [self addChildViewController:_fullVC];
    }
    return _fullVC;
}

@end
