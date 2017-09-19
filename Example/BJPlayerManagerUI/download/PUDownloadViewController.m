//
//  PUDownloadViewController.m
//  BJPlayerManagerUI
//
//  Created by 辛亚鹏 on 2017/9/19.
//  Copyright © 2017年 oushizishu. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>
#import <BJPlayerManagerCore/BJPlayerManagerCore.h>

#import "PUDownloadViewController.h"

#import "PUDownloadManagerViewController.h"
#import "PULocalListTableViewController.h"
#import "MBProgressHUD+bjp.h"

@interface PUDownloadViewController ()
@property (weak, nonatomic) IBOutlet UITextField *vidTF;
@property (weak, nonatomic) IBOutlet UITextField *tokenTF;
@property (weak, nonatomic) IBOutlet UILabel *definitionLabel;
@property (weak, nonatomic) IBOutlet UITextField *definitionTF;

@end

@implementation PUDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    @weakify(self);
    [[self.definitionTF rac_signalForControlEvents:UIControlEventEditingDidEnd | UIControlEventEditingDidEndOnExit] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (![self isNumber:self.definitionTF.text]) {
            [MBProgressHUD bjp_showMessageThenHide:@"请输入0到4的数字" toView:self.view onHide:nil];
        }
    }];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    [[BJCommonHelper sharedBJCommonHelper] setRootPath:path];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)getDefinition:(id)sender {
    @weakify(self);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[BJPlayerManager new] getVideoInfoWithVid:self.vidTF.text token:self.tokenTF.text completion:^(PMVideoInfoModel * _Nullable videoInfo, NSError * _Nullable error) {
        @strongify(self);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            [MBProgressHUD bjp_showMessageThenHide:[error description] toView:self.view onHide:nil];
            self.definitionLabel.text = @"获取失败";
            return ;
        }
        NSString *definitionStr = @"";
        for (PMVideoDefinitionInfoModel *model in videoInfo.definitionList) {
            definitionStr = [definitionStr stringByAppendingString:[NSString stringWithFormat:@" %@", model.definition]];
        }
        self.definitionLabel.text = definitionStr;
        
    }];
}
- (IBAction)download:(id)sender {
    [[BJDownloadManager sharedDownloadManager] downloadWithVid:self.vidTF.text token:self.tokenTF.text definitionType:[self.definitionTF.text integerValue] completion:^(NSError * _Nullable error) {
        if (error) {
            [MBProgressHUD bjp_showMessageThenHide:[error description] toView:self.view onHide:nil];
        }
    }];
}
- (IBAction)downloadManager:(id)sender {
    [self.navigationController pushViewController:[PUDownloadManagerViewController new] animated:YES];
}
- (IBAction)localVideo:(id)sender {
    
    [self.navigationController pushViewController:[PULocalListTableViewController new] animated:YES];
}

- (BOOL)isNumber:(NSString *)str {
    if (str.length == 1  && ([str integerValue] <= 4) && ([str integerValue] >= 0)) {
        return YES;
    }
    else {
        return NO;
    }
}

@end
