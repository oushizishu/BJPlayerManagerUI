//
//  BJPlayerManager.h
//  Pods
//
//  Created by DLM on 2017/2/15.
//
//

#import <Foundation/Foundation.h>
#import <BJVideoPlayer/PKMoviePlayer.h>
#import "PMVideoInfoModel.h"
#import "BJPMProtocol.h"
#import "PMPlayerMacro.h"
#import "PMADPlayerView.h"

@protocol BJPMControlProtocol;

NS_ASSUME_NONNULL_BEGIN

@interface BJPlayerManager : NSObject <BJPMControlProtocol>

@property (nonatomic, weak, nullable) id<BJPMProtocol> delegate;

/**
 存放用户自定义消息
 */
@property (nonatomic, strong, nullable) NSString *userInfo;

/**
 adView
 */
@property (nonatomic, nullable) PMADPlayerView *adPlayerView;

/**
 播放本地视频

 @param path 本地视频路径
 @param definition 需传low, high, sueprHD, 否则返回"未知清晰度"
 */
- (void)setVideoPath:(NSString *)path
          definition:(PMVideoDefinitionType)definition;


/**
 设置播放ID, 自动播放
 
 @param vid 视频Id
 @param token token (该token需要客户的后端调百家云后端的API获取,然后传给移动端)
 */
- (void)setVideoID:(NSString *)vid token:(NSString *)token;

/**
 设置播放ID 获取视频相关信息

 @param vid 视频Id
 @param token token (该token需要客户的后端调百家云后端的API获取,然后传给移动端)
 @param completion 回调信息  return是否自动播放
 */
- (void)setVideoID:(NSString *)vid
             token:(NSString *)token
        completion:(BOOL(^)(PMVideoInfoModel *result, NSError *error))completion;

/**
 获取指定vid的播放信息
 
 @param vid 视频Id
 @param token token (该token需要客户的后端调百家云后端的API获取,然后传给移动端)
 */
- (void)getVideoInfoWithVid:(NSString *)vid
                      token:(NSString *)token
                 completion:(void(^)(PMVideoInfoModel  * _Nullable videoInfo, NSError  * _Nullable error))completion;


/**
 外部定制接口
 用于云端录制的回放功能
 设置播放信息
 
 @param url 回放的url
 @param classId 教室号
 @param modelClass 传进来的模型类的string
 @param token 外界传进来的token
 @param completed  id x 返回传入的模型实例
 */

- (void)setURL:(NSString *)url
       classId:(NSString *)classId
     sessionId:(nullable NSString *)sessionId
    modelClass:(NSString *)modelClass
         token:(NSString *)token
     completed:(void(^) (id x))completed;


/**
 回放定制接口

 @param classId classId
 @param sessionId sessionId
 @param token token
 @param completion completion
 */
- (void)getPlaybackInfoWithClassId:(NSString *)classId
                         sessionId:(nullable NSString *)sessionId
                             token:(NSString *)token
                        completion:(void (^)(PMVideoInfoModel  * _Nullable videoInfo, NSError  * _Nullable error))completion;

/**
 切换到激活状态
 */
- (void)becomeActivity;

/**
 切换到后台，也就是末激活状态
 */
- (void)becomeBackground;

/**
 重置水印
 
 外界当屏幕变化的时候可以重置水印,内部会判断当前食品是否有水印
 */
- (void)resetWaterMark;

@end

#pragma mark - playInfo

@interface BJPlayerManager (playInfo)

/**
 设置视频的起始播放时间, 需要在实例化playerManager对象后 && 调用播放函数之前 设置
 */
@property (nonatomic, assign) NSTimeInterval initialPlaybackTime;

/**
 当前播放状态
 */
@property (nonatomic, readonly) PMPlayState playState;

/**
 视频的时长 支持KVO
 */
@property (nonatomic, readonly) NSTimeInterval duration;

/**
 视频缓存时长
 */
@property (nonatomic, readonly) NSTimeInterval cacheDuration;

/**
 当前播放倍速
 */
@property (nonatomic, readonly) CGFloat playRate;

/**
 正片的当前的播放时间, 支持KVO
 */
@property (nonatomic, readonly) NSTimeInterval currentTime;

/**
 播放器实例
 */
@property (readonly, nullable) PKMoviePlayerController *player;

/**
 播放信息
 */
@property (nonatomic, readonly, nullable) PMVideoInfoModel *videoInfoModel;

/**
 当前播放清晰度
 */
@property (nonatomic, readonly, nullable) PMVideoDefinitionInfoModel *currDefinitionInfoModel;

/**
 当前播放的CDN
 */
@property (nonatomic, readonly, nullable) PMVideoCDNInfoModel *currCDNInfoModel;

@end

#pragma mark - uploadLog
@interface BJPlayerManager (uploadLog)

/**
 创建log文件, 会删除已有的logfile
 */
- (void)createLogFile;

/**
 上传Debug日志信息
 注意:需要在AFURLResponseSerialization.m，我们在第228行添加"text/html"即可, 如下
 
 self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
 
 @param partnerId partnerId
 @param userId 用户ID
 @param vid 回放的话,填写教室号, 点播的话, 填写视频ID
 @param complete complete description
 */
- (void)uploadLogWithPartnerId:(NSString *)partnerId userId:(NSString *)userId vid:(NSString *)vid
                      complete:(void (^)(id  _Nullable responseObject, NSError * _Nullable error))complete;

/**
 关闭文件, 停止日志写入
 */
- (void)closeLog;

/**
 删除Log文件夹
 */
- (void)delLogDirectory;

@end

#pragma mark - playerAD

@interface BJPlayerManager (playerAD)

- (void)setupADPlayerViewWithADModel:(PMVideoADInfoModel *)adModel isHeaderAD:(BOOL)isHeaderAD;

@end

#pragma mark - protocol

@protocol BJPMControlProtocol <NSObject>

- (void)play;

- (void)pause;

- (void)stop;

- (void)seek:(NSTimeInterval)time;

- (void)changeRate:(CGFloat)rate;

/**
 变换清晰度

 @param dt DT_LOW, DT_HIGH, DT_SUPPERHD
 */
- (void)changeDefinition:(PMVideoDefinitionType)dt;

@end

#pragma mark - Deprecated

@interface BJPlayerManager (Deprecated)

/**
 设置合作方ID
 
 @param partnerId 合作方id
 */
- (void)setPartnerId:(NSString *)partnerId PM_Will_DEPRECATED("[[PMAppConfig sharedInstance] setPartnerId:]");

@end

NS_ASSUME_NONNULL_END
