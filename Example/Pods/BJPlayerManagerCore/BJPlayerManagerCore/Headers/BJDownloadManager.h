//
//  BJDownloadManager.h
//  Pods
//
//  Created by 辛亚鹏 on 2017/6/16.
//
//

#import <Foundation/Foundation.h>
#import "BJPlayerManager.h"
#import "PMDownloader.h"

NS_ASSUME_NONNULL_BEGIN

@interface BJDownloadManager : NSObject

+ (instancetype)manager;

/**
 下载视频任务

 @param vid 视频id
 @param token token
 @param definitionType 需要下载的清晰度
 @param progressBlock 进度回调
 @param stateBlock 下载状态回调
 @param completionBlock 失败的回调
 */
- (void)downloadWithVid:(NSString*)vid
                  token:(NSString *)token
         definitionType:(PMVideoDefinitionType)definitionType
               progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress))progressBlock
                  state:(void(^)(DownloadState state))stateBlock
                completion:(void(^)(NSString * _Nullable  filePath, NSError * _Nullable error))completionBlock;


- (void)handle:(NSString *)vid definitionType:(PMVideoDefinitionType)type;

- (void)pause:(NSString *)vid definitionType:(PMVideoDefinitionType)type;

- (void)resume:(NSString *)vid definitionType:(PMVideoDefinitionType)type;

- (void)cancel:(NSString *)vid definitionType:(PMVideoDefinitionType)type;

- (void)pauseAllTask;
- (void)resumeAllTask;
- (void)cancelAllTask;


#pragma mark -

- (CGFloat)progress:(NSString *)vid definitionType:(PMVideoDefinitionType)type;

- (NSInteger)fileTotalLength:(NSString *)vid definitionType:(PMVideoDefinitionType)type;

- (void)progressInfo:(NSString *)vid definitionType:(PMVideoDefinitionType)type progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress))progressBlock;

- (void)state:(NSString *)vid definitionType:(PMVideoDefinitionType)type state:(void(^)(DownloadState state))stateBlock;

- (BOOL)isCompletion:(NSString *)vid definitionType:(PMVideoDefinitionType)type;

@property (nonatomic, readonly) NSString *loadingDirectory;    //下载过程中使用的文件夹
@property (nonatomic, readonly) NSString *completedDirectory;  //下载完成的文件存在的文件夹

@end

NS_ASSUME_NONNULL_END
