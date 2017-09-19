//
//  PULocalListTableViewController.m
//  BJPlayerManagerUI
//
//  Created by 辛亚鹏 on 2017/9/19.
//  Copyright © 2017年 oushizishu. All rights reserved.
//

#import <BJPlayerManagerCore/BJDownloadManager.h>
#import "PULocalListTableViewController.h"
#import "PMLocalViewViewController.h"

@interface PULocalListTableViewController ()

@property (atomic, strong) NSArray *downloadObjectArr;

@end

@implementation PULocalListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.downloadObjectArr = [BJDownloadManager sharedDownloadManager].finishedlist;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.downloadObjectArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BJFileModel *model = [self.downloadObjectArr objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"list"];
    
    cell.textLabel.text = model.fileName;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BJFileModel *model = [self.downloadObjectArr objectAtIndex:indexPath.row];
    PMLocalViewViewController *vc = [[PMLocalViewViewController alloc] initWithPath:model.filePath definitionType:model.definionType];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
