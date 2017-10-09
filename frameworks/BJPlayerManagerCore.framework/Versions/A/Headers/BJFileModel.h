//
//  BJFileModel.h
//  Pods
//
//  Created by 辛亚鹏 on 2017/9/19.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PMVideoInfoModel.h"

typedef NS_ENUM(NSInteger,BJDownLoadState) {
    BJDownloading,      //下载中
    BJWillDownload,     //等待下载
    BJStopDownload      //停止下载
};


@interface BJFileModel : NSObject

/** 展示用的的文件名 */
@property (nonatomic, copy) NSString        *showFileName;
/** 内部下载用的文件名 */
@property (nonatomic, copy) NSString        *fileName;
/** 文件的总长度 */
@property (nonatomic, copy) NSString        *fileSize;
/** 文件的类型(文件后缀,比如:mp4)*/
@property (nonatomic, copy) NSString        *fileType;
/** 是否是第一次接受数据，如果是则不累加第一次返回的数据长度，之后变累加 */
@property (nonatomic, assign) BOOL          isFirstReceived;
/** 文件已下载的长度 */
@property (nonatomic, copy) NSString        *fileReceivedSize;
/** 接受的数据 */
@property (nonatomic, strong) NSMutableData *fileReceivedData;
/** 下载文件的URL */
@property (nonatomic, copy) NSString        *fileURL;
/** 下载时间 */
@property (nonatomic, copy) NSString        *time;
/** 临时文件路径 */
@property (nonatomic, copy) NSString        *tempPath;
/** 文件下载后的路径 */
@property (nonatomic, copy) NSString        *filePath;
/** 下载速度 */
@property (nonatomic, copy) NSString        *speed;
/** 开始下载的时间 */
@property (nonatomic, strong) NSDate        *startTime;
/** 剩余下载时间 */
@property (nonatomic, copy) NSString        *remainingTime;
/** 点播视频Id */
@property (nonatomic, copy) NSString        *vid;
/** 回放classId */
@property (nonatomic, copy) NSString        *classId;
/** 回放sessionId */
@property (nonatomic, copy) NSString        *sessionId;
/** token */
@property (nonatomic, copy) NSString        *token;
/** token */
@property (nonatomic, assign) PMVideoDefinitionType   definionType;

/*下载状态的逻辑是这样的：三种状态，下载中，等待下载，停止下载
 *当超过最大下载数时，继续添加的下载会进入等待状态，当同时下载数少于最大限制时会自动开始下载等待状态的任务。
 *可以主动切换下载状态
 *所有任务以添加时间排序。
 */
@property (nonatomic, assign) BJDownLoadState downloadState;
/** 是否下载出错 */
@property (nonatomic, assign) BOOL            error;
/** md5 */
@property (nonatomic, copy) NSString          *MD5;
/** 文件的附属图片 */
@property (nonatomic,strong) UIImage          *fileimage;


@end
