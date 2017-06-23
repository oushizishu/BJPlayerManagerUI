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

@protocol BJPMControlProtocol;

NS_ASSUME_NONNULL_BEGIN

@interface BJPlayerManager : NSObject <BJPMControlProtocol>

@property (nonatomic, weak, nullable) id<BJPMProtocol> delegate;

/**
 存放用户自定义消息
 */
@property (nonatomic, strong, nullable) NSString *userInfo;

/**
 播放本地视频

 @param path 本地视频路径
 @param definition 需传low, high, sueprHD, 否则返回"未知清晰度"
 */
- (void)setVideoPath:(NSString *)path
          definition:(PMVideoDefinitionType)definition;


/**
 设置播放ID
 
 @param vid 视频Id
 @param token 请求 url 的 token
 */
- (void)setVideoID:(NSString *)vid token:(NSString *)token;

/**
 设置播放ID 获取视频相关信息

 @param vid 视频Id
 @param token 请求 url 的 token
 @param completion 回调信息  return是否自动播放
 */
- (void)setVideoID:(NSString *)vid
             token:(NSString *)token
        completion:(BOOL(^)(PMVideoInfoModel *result, NSError *error))completion;

/**
 获取指定vid的播放信息
 
 @param vid 视频Id
 @param token 请求 url 的 token
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
    modelClass:(NSString *)modelClass
         token:(NSString *)token
     completed:(void(^) (id x))completed;

/**
 切换到激活状态
 */
- (void)becomeActivity;

/**
 切换到后台，也就是末激活状态
 */
- (void)becomeBackground;

@end

@interface BJPlayerManager (playInfo)

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

@interface BJPlayerManager (uploadLog)

/**
 上传Debug日志信息
 注意:需要在AFURLResponseSerialization.m，我们在第228行添加"text/html"即可, 如下
 
 self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
 
 @param partnerId partnerId
 @param userId userId
 @param complete complete description
 */
- (void)uploadLogWithPartnerId:(NSString *)partnerId userId:(NSString *)userId
                      complete:(void (^)(id  _Nullable responseObject, NSError * _Nullable error))complete;

@end

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

@interface BJPlayerManager (Deprecated)

/**
 设置合作方ID
 
 @param partnerId 合作方id
 */
- (void)setPartnerId:(NSString *)partnerId PM_Will_DEPRECATED("[[PMAppConfig sharedInstance] setPartnerId:]");

@end

NS_ASSUME_NONNULL_END
