# 百家云点播SDK使用接口文档
## 1、	项目中设置依赖关系
cocoapod集成SDK，在podfile中添加以下内容：

```
workspace 'xxxx.xcworkspace'
project 'xxxx.xcodeproj'

source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/baijia/specs.git'

target :xxxx do
    pod 'BJHL-VideoPlayer-Manager'
end
```


## 2、	设置环境
可以设置项目环境，包括test、beta、www
```
#import "PMAppConfig.h"

@property (nonatomic) PMDeployType deployType;

```


## 3、	创建播放器
```
#import "PMPlayerViewController.h"
self.player = [[BJPlayerManager alloc] init];
self.player.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*9/16);
[self.view addSubview:self.player.view];
```

## 4、	播放

- 播放接口, 需要传入vid和token
```
/**
 设置播放信息

 @param vid videoId
 @param type mp4:1/m3u8:2/flv:3
 @param token 鉴权使用
 */
- (void)setVideoID:(NSString *)vid type:(NSString *)type token:(NSString *)token;
```

- 回放播放接口
```
/**
 外部定制接口
 用于云端录制的回放功能
 设置播放信息
 
 @param url 外部指定的url,由此url获取信令文件和播放信息
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
```

- 本地播放接口
```
/**
 播放本地视频

 @param path 本地视频路径
 @param startVideo 片头地址
 @param endVideo 片尾地址
 @param definitionKey 需传low, high, sueprHD, 否则返回"未知清晰度"
 */
- (void)setVideoPath:(NSString *)path
          startVideo:(nullable NSString *)startVideo
            endVideo:(nullable NSString *)endVideo
          definition:(PMVideoDefinitionType)definition;

```

## 5、	播放和加载的通知
```
- 播放:
监听PKMoviePlayerPlaybackStateDidChangeNotification来获取PKMoviePlayerController的playbackState
- 加载:
监听PKMoviePlayerLoadStateDidChangeNotification来获取PKMoviePlayerController的loadState
- 播放结束或者出错:
监听PKMoviePlayerPlaybackDidFinishNotification, 根据通知的userinfo中的PKMoviePlayerPlaybackDidFinishReasonUserInfoKey的value来判断结束的原因
```


## 6、	界面定制

```
#import "PMPlayerViewController.h"
self.player = [[BJPlayerManager alloc] init];
self.player.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*9/16);
[self.view addSubview:self.player.view];
```


- 视频播放信息
```
- 在BJPlayerManager.h的videoInfoModel里面可以获取在线视频时长.
- 当前的播放时刻, 在BJPlayerManager.h的player.currentPlaybackTime
```


- 可通过以下消息来向播放器发送控制
```
/**
 播放
 */
- (void)play;

/**
 暂停
 */
- (void)pause;

/**
 停止
 */
- (void)stop;

/**
 seek，快进 快退

 @param time 时间，单位为秒
 */
- (void)seek:(NSTimeInterval)time;

/**
 改变播放倍速

 @param rate 要改变的倍速
 */
- (void)changeRate:(CGFloat)rate;

/**
 改变清晰度

 @param  DT_LOW, DT_HIGH, DT_SUPPERHD
 */
- (void)changeDefinition:(PMVideoDefinitionType)dt;
```


