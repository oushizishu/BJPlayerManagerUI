//
//  PUDownloadManagerViewController.m
//  BJPlayerManagerUI
//
//  Created by 辛亚鹏 on 2017/9/19.
//  Copyright © 2017年 oushizishu. All rights reserved.
//

#import "PUDownloadManagerViewController.h"
#import <BJPlayerManagerCore/BJPlayerManagerCore.h>
#import "BJDownloadingTableViewCell.h"
#import "BJDownloadedTableViewCell.h"

#define  DownloadManager  [BJDownloadManager sharedDownloadManager]

@interface PUDownloadManagerViewController ()<BJDownloadDelegate,UITableViewDataSource,UITableViewDelegate>

@property ( nonatomic) UITableView *tableView;

@property (atomic, strong) NSMutableArray *downloadObjectArr;

@end

@implementation PUDownloadManagerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 更新数据源
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain] ;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -49, 0);
    DownloadManager.downloadDelegate = self;
    //    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BJDownloadingTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"downloadingCell"];
    [self.tableView registerClass:[BJDownloadingTableViewCell class] forCellReuseIdentifier:@"downloadingCell"];
    //NSLog(@"%@", NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES));
    
    [self setupBarButton];
    
}

- (void)setupBarButton {
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithTitle:@"开始所有" style:UIBarButtonItemStylePlain target:self action:@selector(startAll:)];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithTitle:@"暂停所有" style:UIBarButtonItemStylePlain target:self action:@selector(pauseAll:)];
    self.navigationItem.rightBarButtonItems = @[rightItem2, rightItem1];
}

- (void)initData
{
    [DownloadManager startLoad];
    NSMutableArray *downladed = DownloadManager.finishedlist;
    NSMutableArray *downloading = DownloadManager.downinglist;
    self.downloadObjectArr = @[].mutableCopy;
    [self.downloadObjectArr addObject:downladed];
    [self.downloadObjectArr addObject:downloading];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = self.downloadObjectArr[section];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BJDownloadedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadedCell"];
        if (!cell) {
            cell = [[BJDownloadedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"downloadedCell"];
        }
        BJFileModel *fileInfo = self.downloadObjectArr[indexPath.section][indexPath.row];
        cell.fileInfo = fileInfo;
        return cell;
    } else if (indexPath.section == 1) {
        BJDownloadingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadingCell"];
        if (!cell) {
            cell = [[BJDownloadingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"downloadingCell"];
        }
        BJHttpRequest *request = self.downloadObjectArr[indexPath.section][indexPath.row];
        if (request == nil) { return nil; }
        BJFileModel *fileInfo = [request.userInfo objectForKey:@"File"];
        
        __weak typeof(self) weakSelf = self;
        // 下载按钮点击时候的要刷新列表
        cell.btnClickBlock = ^{
            [weakSelf initData];
        };
        // 下载模型赋值
        cell.fileInfo = fileInfo;
        // 下载的request
        cell.request = request;
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BJFileModel *fileInfo = self.downloadObjectArr[indexPath.section][indexPath.row];
        [DownloadManager deleteFinishFile:fileInfo];
    }else if (indexPath.section == 1) {
        BJHttpRequest *request = self.downloadObjectArr[indexPath.section][indexPath.row];
        [DownloadManager deleteRequest:request];
    }
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @[@"下载完成",@"下载中"][section];
}

#pragma mark - BJDownloadDelegate

// 开始下载
- (void)startDownload:(BJHttpRequest *)request
{
    NSLog(@"开始下载!");
}

// 下载中
- (void)updateCellProgress:(BJHttpRequest *)request
{
    BJFileModel *fileInfo = [request.userInfo objectForKey:@"File"];
    [self performSelectorOnMainThread:@selector(updateCellOnMainThread:) withObject:fileInfo waitUntilDone:YES];
}

// 下载完成
- (void)finishedDownload:(BJHttpRequest *)request
{
    [self initData];
}

// 更新下载进度
- (void)updateCellOnMainThread:(BJFileModel *)fileInfo
{
    NSArray *cellArr = [self.tableView visibleCells];
    for (id obj in cellArr) {
        if([obj isKindOfClass:[BJDownloadingTableViewCell class]]) {
            BJDownloadingTableViewCell *cell = (BJDownloadingTableViewCell *)obj;
            if([cell.fileInfo.fileURL isEqualToString:fileInfo.fileURL]) {
                cell.fileInfo = fileInfo;
            }
        }
    }
}

- (void)startAll:(id)sender {
    [DownloadManager startAllDownloads];
}

- (void)pauseAll:(id)sender {
    [DownloadManager pauseAllDownloads];
}

@end
