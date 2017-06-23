//
//  PMDownloadTableViewCell.h
//  BJPlayerManagerCore
//
//  Created by 辛亚鹏 on 2017/6/19.
//  Copyright © 2017年 oushizishu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMDownloadModel.h"

extern NSString *kDownloadCell;

@interface PMDownloadTableViewCell : UITableViewCell

@property (nonatomic) void(^pauseBlock)(PMDownloadTableViewCell *cell);
@property (nonatomic) void(^playBlock)(PMDownloadTableViewCell *cell);
@property (nonatomic) void(^cancelBlock)(PMDownloadTableViewCell *cell);

@property (weak, nonatomic) IBOutlet UIButton *pause;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *size;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

- (void)setValueWithModel:(PMDownloadModel *)model;

@end
