//
//  PMDownloadViewController.m
//  BJPlayerManagerCore
//
//  Created by 辛亚鹏 on 2017/6/19.
//  Copyright © 2017年 oushizishu. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <BJPlayerManagerCore/BJDownloadManager.h>

#import "PMDownloadViewController.h"
#import "PMDownloadTableViewCell.h"
#import "PMDownloadModel.h"
#import "PMLocalViewViewController.h"

#import "NSString+md5.h"
#import "MBProgressHUD+bjp.h"

#define YPWeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define YPStrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

static NSString *tempArrPath;

@interface PMDownloadViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *vidTextField;
@property (weak, nonatomic) IBOutlet UITextField *tokenTextField;
@property (nonatomic) NSMutableArray <PMDownloadModel *> *taskArrM;
@property (weak, nonatomic) IBOutlet UIButton *pauseAll;
@property (weak, nonatomic) IBOutlet UIButton *resumeAll;
@property (weak, nonatomic) IBOutlet UIButton *cancelAll;

@end

@implementation PMDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSegment];
    [self setupTableView];
    
    tempArrPath = [[BJDownloadManager manager].loadingDirectory stringByAppendingPathComponent:@"taskArr.plist"];
    self.taskArrM = [NSMutableArray array];
    
    [self decodeFromLocalFile];
    
    self.vidTextField.text = @"129547";
    self.tokenTextField.text = @"test12345678";
}

- (void)setupSegment
{
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"标清", @"高清", @"超清"]];
    self.segment.selectedSegmentIndex = 0;
    [self.view addSubview:self.segment];
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(170.f);
        make.width.equalTo(@200);
        make.height.equalTo(@25);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark - actions

- (IBAction)download:(UIButton *)sender {
    NSInteger selectedIndex = self.segment.selectedSegmentIndex;
    PMVideoDefinitionType type;
    switch (selectedIndex) {
        case 0:
            type = DT_LOW;
            break;
        case 1:
            type = DT_HIGH;
            break;
        case 2:
            type = DT_SUPPERHD;
            break;
            
        default:
            break;
    }
    
    if ([self vid:self.vidTextField.text type:selectedIndex]) {
         [MBProgressHUD bjp_showMessageThenHide:@"已在下载队列或者已经下载完成" toView:self.view onHide:nil];
    }
    else {
        PMDownloadModel *model = [PMDownloadModel new];
        model.vid = self.vidTextField.text;
        model.token = self.tokenTextField.text;
        model.definitionType = selectedIndex;
        [self.taskArrM addObject:model];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.taskArrM.count-1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self saveLocal:self.taskArrM];
    }
}

- (IBAction)pauseAll:(id)sender {
    if ([self taskComplete]) {
//        [MBProgressHUD bjp_showMessageThenHide:@"所有任务已经下载完成, 无法操作" toView:self.view onHide:nil];
    }
    else {
        [[BJDownloadManager manager] pauseAllTask];
    }
}

- (IBAction)resumeAll:(id)sender {
    if ([self taskComplete]) {
//        [MBProgressHUD bjp_showMessageThenHide:@"所有任务已经下载完成, 无法操作" toView:self.view onHide:nil];
    }
    else {
        [[BJDownloadManager manager] resumeAllTask];
    }
}

- (IBAction)cancelAll:(id)sender {
    if ([self taskComplete]) {
//        [MBProgressHUD bjp_showMessageThenHide:@"所有任务已经下载完成, 无法操作" toView:self.view onHide:nil];
    }
    else {
        [[BJDownloadManager manager] cancelAllTask];
        [self saveLocal:self.taskArrM];
    }
}

#pragma mark - 添加任务到下载队列

- (void)downloadWith:(NSString *)vid token:(NSString *)token defintype:(NSInteger)defintype cell:(__weak PMDownloadTableViewCell *)cell {
    @YPWeakObj(self);
    [[BJDownloadManager manager] downloadWithVid:vid token:token definitionType:defintype progress:^(NSInteger pm_receivedSize, NSInteger pm_expectedSize, CGFloat pm_progress) {
        cell.size.text = [NSString stringWithFormat:@" %.2fM / %.2fM", pm_receivedSize / 1024.0 / 1024.0 , pm_expectedSize / 1024.0 / 1024.0];
        cell.progressLabel.text = [NSString stringWithFormat:@"%.2f%%", pm_progress * 100];
        cell.progressView.progress = pm_progress;
        
        PMDownloadModel *model = [self.taskArrM objectAtIndex:[self.tableView indexPathForCell:cell].row];
        model.progress = pm_progress;
        model.totalSize = pm_expectedSize;
        model.receiveSize = pm_receivedSize;

        [self saveLocal:self.taskArrM];

    } state:^(DownloadState pm_state) {
        @YPStrongObj(self);
        if (self.taskArrM.count < 1) {
            return ;
        }
        PMDownloadModel *model = [self.taskArrM objectAtIndex:[self.tableView indexPathForCell:cell].row];
        cell.stateLabel.text = [self stateString:pm_state];
        model.state = pm_state;
        [self saveLocal:self.taskArrM];
        
        if (pm_state == 0) {
            [cell.pause setTitle:@"暂停" forState:UIControlStateNormal];
        }
        else if (pm_state == 1) {
            [cell.pause setTitle:@"开始" forState:UIControlStateNormal];
        }
        else if ((pm_state == 3) || (pm_state == 4)) {
            [cell.pause setTitle:@"重试" forState:UIControlStateNormal];
        }
        else if (pm_state == 2) {
            [cell.pause setTitle:@"完成" forState:UIControlStateNormal];
            cell.pause.enabled = NO;
        }
        
        if (pm_state == DownloadStateCompleted) {
            cell.pause.enabled = NO;
            cell.cancel.enabled = NO;
            cell.playBtn.enabled = YES;
            cell.progressView.progress = 1.0;
            cell.progressLabel.text = @"100.00%";
            model.state = DownloadStateCompleted;
            NSUInteger size = [[BJDownloadManager manager] fileTotalLength:model.vid definitionType:model.definitionType];
            cell.size.text = [NSString stringWithFormat:@" %.2fM / %.2fM", size / 1024.0 / 1024.0 , size / 1024.0 / 1024.0];
        }
        else {
            cell.pause.enabled = YES;
            cell.cancel.enabled = YES;
            cell.playBtn.enabled = NO;
        }
    } completion:^(NSString * _Nullable pm_filePath, NSError * _Nullable pm_error) {
        @YPStrongObj(self);
        if (pm_error) {
            [MBProgressHUD bjp_showMessageThenHide:[NSString stringWithFormat:@"error的原因是:%@", [pm_error description]] toView:self.view onHide:nil];
            [cell.pause setTitle:@"重试" forState:UIControlStateNormal];
            NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
            PMDownloadModel *mod = [self.taskArrM objectAtIndex:indexP.row];
            [[BJDownloadManager manager] cancel:mod.vid definitionType:mod.definitionType];
            [self.taskArrM removeObject:mod];
            [self saveLocal:self.taskArrM];

            [self.tableView deleteRowsAtIndexPaths:@[indexP] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }
        else {
//            [MBProgressHUD bjp_showMessageThenHide:[NSString stringWithFormat:@"下载完成后的路径:%@", pm_filePath] toView:self.view onHide:nil];
        }
    }];
}

#pragma mark - helper

- (BOOL)vid:(NSString *)vid type:(NSInteger)type {
    
    NSString *idfi = [NSString stringWithFormat:@"%@%li", vid, type];
    for (PMDownloadModel *tempModel in self.taskArrM) {
        if ([idfi isEqualToString:tempModel.modelIdfi]) {
            return YES;
        }
    }
    return NO;
}

- (PMDownloadModel *)modelWithVid:(NSString *)vid type:(NSInteger)type {
    
    NSString *idfi = [NSString stringWithFormat:@"%@%li", vid, type];
    for (PMDownloadModel *tempModel in self.taskArrM) {
        if ([idfi isEqualToString:tempModel.modelIdfi]) {
            return tempModel;
        }
    }
    return nil;
}

- (void)saveLocal:(NSArray *)arr{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *tempArrM = [NSMutableArray array];
        for (PMDownloadModel *model in arr) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
            [tempArrM addObject:data];
        }
        [tempArrM writeToFile:tempArrPath atomically:YES];
    });
}

- (BOOL)decodeFromLocalFile{
    NSArray *arr = [NSArray arrayWithContentsOfFile:tempArrPath];
    if (!arr) {
        return NO;
    }
    for (NSData *data in arr) {
        PMDownloadModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [self.taskArrM addObject:model];
    }
    return YES;
}

- (BOOL)taskComplete {

    for (PMDownloadModel *model in self.taskArrM) {
        if (model.state != DownloadStateCompleted) {
            return NO;
        }
    }
    return YES;
}

- (NSInteger)downloadingTaskCount {
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (PMDownloadModel *model in self.taskArrM) {
        if (model.state == DownloadStateCompleted) {
            [tmpArr addObject:model];
        }
    }
    return tmpArr.count;
}

#pragma mark - 

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - tableView

- (void)setupTableView {
//    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    [self.tableView registerNib:[UINib nibWithNibName:@"PMDownloadTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kDownloadCell];
    self.tableView.scrollEnabled = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.taskArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMDownloadModel *model = [self.taskArrM objectAtIndex:indexPath.row];

//    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%zd%zd", [indexPath section], [indexPath row]];
//    PMDownloadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    PMDownloadTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"PMDownloadTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([self stateWithString:cell.stateLabel.text] == -1) {
        [cell.pause setTitle:@"暂停" forState:UIControlStateNormal];
        [self downloadWith:model.vid token:model.token defintype:model.definitionType cell:cell];
    }
    else if ([self stateWithString:cell.stateLabel.text] == 2) {
        [cell.pause setTitle:@"完成" forState:UIControlStateNormal];
        cell.pause.enabled = NO;
    }
    
    [cell setValueWithModel:model];

    @YPWeakObj(self);
    cell.pauseBlock = cell.pauseBlock ?: ^(PMDownloadTableViewCell *cel) {
        @YPStrongObj(self);
        NSIndexPath *indexP = [self.tableView indexPathForCell:cel];
        PMDownloadModel *mod = [self.taskArrM objectAtIndex:indexP.row];

        if (([self stateWithString:cel.stateLabel.text] == -1) || ([self stateWithString:cell.stateLabel.text] == 3) ||  ([self stateWithString:cell.stateLabel.text] == 4) ) {
            [self downloadWith:mod.vid token:mod.token defintype:mod.definitionType cell:cell];
        }
        else if ([self stateWithString:cel.stateLabel.text] == 0) {
            [self downloadWith:mod.vid token:mod.token defintype:mod.definitionType cell:cell];
        }
        else if ([self stateWithString:cel.stateLabel.text] == 1) {
            [self downloadWith:mod.vid token:mod.token defintype:mod.definitionType cell:cell];
        }
    };
    
    cell.cancelBlock = cell.cancelBlock ?: ^(PMDownloadTableViewCell *cel) {
        @YPStrongObj(self);
        NSIndexPath *indexP = [self.tableView indexPathForCell:cel];
        PMDownloadModel *mod = [self.taskArrM objectAtIndex:indexP.row];
        [[BJDownloadManager manager] cancel:mod.vid definitionType:mod.definitionType];
        [self.taskArrM removeObject:mod];
        [self saveLocal:self.taskArrM];
//        [self.tableView deselectRowAtIndexPath:indexP animated:NO];
        [tableView deleteRowsAtIndexPaths:@[indexP] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [cel.pause setTitle:@"重试" forState:UIControlStateNormal];
//        [MBProgressHUD bjp_showMessageThenHide:@"任务和缓存文件已删除" toView:self.view onHide:nil];
    };
    
    cell.playBlock = cell.playBlock ?: ^(PMDownloadTableViewCell *cel) {
        @YPStrongObj(self);
        NSIndexPath *indexP = [self.tableView indexPathForCell:cel];
        PMDownloadModel *mod = [self.taskArrM objectAtIndex:indexP.row];
        NSString *path = [self completedPath:mod.vid type:mod.definitionType];
        PMLocalViewViewController *vc = [[PMLocalViewViewController alloc] initWithPath:path definitionType:model.definitionType];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.f;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    PMDownloadModel *model = [self.taskArrM objectAtIndex:indexPath.row];
    NSString *path = [self completedPath:model.vid type:model.definitionType];
    if (path.length > 0) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    else {
        [[BJDownloadManager manager] cancel:model.vid definitionType:model.definitionType];
    }
    [self.taskArrM removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self saveLocal:self.taskArrM];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"彻底删除文件";
}

#pragma amrk - util

- (NSString *)stateString:(NSInteger)state
{
    NSString *str = @"未知";
    switch (state) {
        case 0:
            str = @"下载中";
            break;
            
        case 1:
            str = @"暂停";
            break;
            
        case 2:
            str = @"完成";
            break;
            
        case 3:
            str = @"取消";
            break;
            
        case 4:
            str = @"失败";
            break;
        default:
            break;
    }
    return str;
}

- (NSInteger)stateWithString:(NSString *)string {
    
    if ([string isEqualToString:@"下载中"]) {
        return 0;
    }
    else if([string isEqualToString:@"暂停"]) {
        return 1;
    }
    else if([string isEqualToString:@"完成"]) {
        return 2;
    }
    else if([string isEqualToString:@"取消"]) {
        return 3;
    }
    else if([string isEqualToString:@"失败"]) {
        return 4;
    }
    return -1;
}
- (nullable NSString *)completedPath:(NSString *)vid type:(PMVideoDefinitionType)type {
    NSString *definotionStr = @"";
    if (type == 0) {
        definotionStr = @"low";
    }
    else if(type == 1) {
        definotionStr = @"high";
    }
    else if (type == 2){
        definotionStr = @"super";
    }
    NSString *taskKey = [NSString stringWithFormat:@"%@%@_video", vid, definotionStr];
    NSString *fileName = [NSString stringWithFormat:@"%@.mp4", taskKey];
    NSString *comPath = [[BJDownloadManager manager].completedDirectory stringByAppendingPathComponent:fileName];
//    NSString *downloadingPath = [[BJDownloadManager manager].loadingDirectory stringByAppendingString:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:comPath]) {
        return comPath;
    }
    return nil;

}

@end
