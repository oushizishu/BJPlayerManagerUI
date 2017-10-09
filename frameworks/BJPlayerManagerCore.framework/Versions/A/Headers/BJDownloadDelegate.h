//
//  BJDownloadDelegate.h
//  Pods
//
//  Created by 辛亚鹏 on 2017/9/19.
//
//

#import <Foundation/Foundation.h>
#import "BJHttpRequest.h"

#import "BJHttpRequest.h"

@protocol BJDownloadDelegate <NSObject>

@optional
- (void)startDownload:(BJHttpRequest *)request;
- (void)updateCellProgress:(BJHttpRequest *)request;
- (void)finishedDownload:(BJHttpRequest *)request;
- (void)allowNextRequest;//处理一个窗口内连续下载多个文件且重复下载的情况

@end
