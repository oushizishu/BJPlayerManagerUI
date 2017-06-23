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
}

@end
