//
//  PMDownloadTool.h
//  Pods
//
//  Created by 辛亚鹏 on 2017/6/6.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DownloadState) {
    DownloadStateStart = 0,     /** 下载中 */
    DownloadStateSuspended,     /** 下载暂停 */
    DownloadStateCompleted,     /** 下载完成 */
    DownloadStateCancel,        /** 下载取消 */
    DownloadStateFailed         /** 下载失败 */
};

@interface PMDownloadSessionModel : NSObject

/** 流 */
@property (nonatomic, strong, nullable) NSOutputStream *stream;

/** 下载地址 */
@property (nonatomic, copy) NSString *url;

/** 获得服务器这次请求 返回数据的总长度 */
@property (nonatomic, assign) NSInteger totalLength;

/** 文件的名称 */
@property (nonatomic, copy) NSString *fileName;

/** 将传入的taskKey进行MD5后存起来 */
//@property (nonatomic, copy) NSString *taskKeyMD5;

/** 将传入的taskKey */
@property (nonatomic, copy) NSString *taskKey;

/** 下载进度 */
@property (nonatomic, copy) void(^progressBlock)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress);

/** 下载状态 */
@property (nonatomic, copy) void(^stateBlock)(DownloadState state);

/** 完成状态 */
@property (nonatomic, copy) void(^ _Nullable completionBlock)(NSString * _Nullable filePath, NSError *_Nullable error);

@end

#pragma mark - downloadTool

@interface PMDownloader : NSObject

/**
 *  单例
 *
 *  @return 返回单例对象
 */
+ (instancetype)sharedInstance;

/**
 *  开启任务下载资源
 *
 *  @param url           下载地址
 *  @param progressBlock 回调下载进度
 *  @param stateBlock    下载状态
 */
- (void)addDownloadTaskWithUrl:(NSString *)url
                       taskKey:(NSString *)taskkey  //传入之前需要对string做MD5处理
                      progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress))progressBlock
                         state:(void(^)(DownloadState state))stateBlock
                    completion:(void(^)(NSString *_Nullable filePath ,NSError *_Nullable error))completion;

#pragma mark - action

/**
 根据当前的下载状态对任务进行暂停或者开始

 @param taskKey taskkey
 */
- (void)handle:(NSString *)taskKey;

/**
 暂停单个
 
 @param url <#url description#>
 */
- (void)pause:(NSString *)url;

/**
 继续单个task
 
 @param url <#url description#>
 */
- (void)start:(NSString *)url;

/**
 *  取消任务, 并删除该资源
 *
 *  @param taskkey 下载地址
 */
- (void)cancel:(NSString *)taskkey;

/**
 暂停所有的任务
 */
- (void)pauseAllTask;

/**
 继续所有任务
 */
- (void)resumeAllTask;

/**
 *  清空所有下载资源
 */
- (void)deleteAllFile;

#pragma mark - info

/**
 *  查询该资源的下载进度值
 *
 *  @param taskKey key
 *
 *  @return 返回下载进度值
 */
- (CGFloat)progress:(NSString *)taskKey;

/**
 *  获取该资源总大小
 *
 *  @param taskKey key
 *
 *  @return 资源总大小
 */
- (NSInteger)fileTotalLength:(NSString *)taskKey;

/**
 下载中的info

 @param taskKey key
 @param progressBlock <#progressBlock description#>
 */
- (void)progressInfo:(NSString *)taskKey progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress))progressBlock;

/**
 返回下载状态

 @param taskKey key
 @param stateBlock <#stateBlock description#>
 */
- (void)state:(NSString *)taskKey state:(void(^)(DownloadState state))stateBlock;

/**
 *  判断该资源是否下载完成
 *
 *  @param taskKey key
 *  @param islocal yes:判断completedDirectory里面的文件, no:判断loadingDirectory里面的文件是都缓存完成
 *  @param fileName 当islocal是yes的时候需要传, no时传nil
 *
 *  @return YES: 完成
 */
- (BOOL)isCompletion:(NSString *)taskKey isLocal:(BOOL)islocal fileName:(NSString *_Nullable)fileName;

/**
 下载过程中使用的文件夹
 */
@property (nonatomic, readonly) NSString *loadingDirectory;

/**
 下载完成的文件存在的文件夹
 */
@property (nonatomic, readonly) NSString *completedDirectory;

@end

NS_ASSUME_NONNULL_END
