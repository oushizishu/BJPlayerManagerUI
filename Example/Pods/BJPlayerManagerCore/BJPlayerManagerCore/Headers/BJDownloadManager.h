//
//  BJDownloadManager.h
//  Pods
//
//  Created by 辛亚鹏 on 2017/9/19.
//
//

#import <Foundation/Foundation.h>
#import "BJCommonHelper.h"
#import "BJDownloadDelegate.h"
#import "BJFileModel.h"
#import "BJHttpRequest.h"
#import "PMVideoInfoModel.h"

#define kMaxRequestCount  @"kMaxRequestCount"

NS_ASSUME_NONNULL_BEGIN

@interface BJDownloadManager : NSObject <BJHttpRequestDelegate>

/** 获得下载事件的vc，用在比如多选图片后批量下载的情况，这时需配合 allowNextRequest 协议方法使用 */
@property (nonatomic, weak ) id<BJDownloadDelegate> VCdelegate;
/** 下载列表delegate */
@property (nonatomic, weak  ) id<BJDownloadDelegate> downloadDelegate;
/** 设置最大的并发下载个数 */
@property (nonatomic, assign) NSInteger              maxCount;
/** 已下载完成的文件列表（文件对象） */
@property (atomic, strong, readonly) NSMutableArray  *finishedlist;
/** 正在下载的文件列表(ASIHttpRequest对象) */
@property (atomic, strong, readonly) NSMutableArray  *downinglist;
/** 未下载完成的临时文件数组（文件对象) */
@property (atomic, strong, readonly) NSMutableArray  *filelist;
/** 下载文件的模型 */
@property (nonatomic, strong, readonly) BJFileModel  *fileInfo;

/** 单例 */
+ (BJDownloadManager *)sharedDownloadManager;
/**
 * 清除所有正在下载的请求
 */
- (void)clearAllRquests;
/**
 * 清除所有下载完的文件
 */
- (void)clearAllFinished;
/**
 * 恢复下载
 */
- (void)resumeRequest:(BJHttpRequest *)request;
/**
 * 删除这个下载请求
 */
- (void)deleteRequest:(BJHttpRequest *)request;
/**
 * 停止这个下载请求
 */
- (void)stopRequest:(BJHttpRequest *)request;
/**
 * 保存下载完成的文件信息到plist
 */
- (void)saveFinishedFile;
/**
 * 删除某一个下载完成的文件
 */
- (void)deleteFinishFile:(BJFileModel *)selectFile;

/**
 点播视频下载

 @param vid 视频ID
 @param token token
 @param definitionType 清晰度
 @param completion 是否有error
 */
- (void)downloadWithVid:(NSString *)vid
                  token:(NSString *)token
         definitionType:(PMVideoDefinitionType)definitionType
             completion:(void (^)(NSError  * _Nullable error))completion;

/**
 回放下载

 @param classId classId
 @param sessionId sessionId 可以为空
 @param token token
 @param definitionType 清晰度
 @param completion error
 */
- (void)downloadWithClassId:(NSString *)classId
                  sessionId:(nullable NSString *)sessionId
                      token:(NSString *)token
             definitionType:(PMVideoDefinitionType)definitionType
                 completion:(void (^)(NSError  * _Nullable error))completion;
/**
 * 开始任务
 */
- (void)startLoad;
/**
 * 全部开始（等于最大下载个数，超过的还是等待下载状态）
 */
- (void)startAllDownloads;
/**
 * 全部暂停
 */
- (void)pauseAllDownloads;

@end

NS_ASSUME_NONNULL_END
