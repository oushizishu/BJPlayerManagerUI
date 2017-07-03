//
//  PMDownloadTableViewCell.m
//  BJPlayerManagerCore
//
//  Created by 辛亚鹏 on 2017/6/19.
//  Copyright © 2017年 oushizishu. All rights reserved.
//

#import "PMDownloadTableViewCell.h"
#import <BJPlayerManagerCore/BJDownloadManager.h>

#define YPWeakObj(objc) autoreleasepool{} __weak typeof(objc) objc##Weak = objc;
#define YPStrongObj(objc) autoreleasepool{} __strong typeof(objc) objc = objc##Weak;

const  NSString *kDownloadCell = @"kDownloadCell";

@implementation PMDownloadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)pause:(UIButton *)sender {
    
    if (self.pauseBlock) {
        self.pauseBlock(self);
    }
}
- (IBAction)play:(id)sender {
    if (self.playBlock) {
        self.playBlock(self);
    }
}
- (IBAction)cancel:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock(self);
    }
}

- (void)setValueWithModel:(PMDownloadModel *)model {
    
    NSString *vid  = model.vid;
    NSInteger type = model.definitionType;
    self.nameLabel.text = [NSString stringWithFormat:@"%@_%li", vid, type];
    CGFloat progress = model.receiveSize / (model.totalSize * 1.000);
    self.size.text = [NSString stringWithFormat:@" %.2fM / %.2fM", model.receiveSize / 1024.0 / 1024.0 , model.totalSize / 1024.0 / 1024.0];
    self.progressLabel.text = [NSString stringWithFormat:@"%.2f%%", progress * 100];
    self.progressView.progress = progress;
    
    self.stateLabel.text = [self stateString:model.state];
    if (model.state == 0) {
        [self.pause setTitle:@"暂停" forState:UIControlStateNormal];
    }
    else if (model.state == 1) {
        [self.pause setTitle:@"开始" forState:UIControlStateNormal];
    }
    else if ((model.state == 3) || (model.state == 4)) {
        [self.pause setTitle:@"重试" forState:UIControlStateNormal];
    }
    else if (model.state == 2) {
        [self.pause setTitle:@"完成" forState:UIControlStateNormal];
        self.pause.enabled = NO;
    }
    
    if (model.state == DownloadStateCompleted) {
        self.pause.enabled = NO;
        self.cancel.enabled = NO;
        self.playBtn.enabled = YES;
        self.progressView.progress = 1.0;
        self.progressLabel.text = @"100.00%";
    }
    else {
        self.pause.enabled = YES;
        self.cancel.enabled = YES;
        self.playBtn.enabled = NO;
    }
}

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


@end
