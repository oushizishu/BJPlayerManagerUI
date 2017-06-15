//
//  BJUpdate.h
//  Pods
//
//  Created by Mac_ZL on 16/8/26.
//
//

#import <Foundation/Foundation.h>

typedef void(^UpdateHandle)(BOOL isForce,NSString *version,NSString *downloadUrl,NSString *updateLog);

typedef NS_ENUM(NSUInteger, BJUpdateType) {
    BJUpdateTypeTeacher = 1,
    BJUpdateTypeStudent = 2,
    BJUpdateTypeOrg = 4,
    BJUpdateTypePubMed = 9,
    BJUpdateTypeTianxiao = 10,
    BJUpdateTypeJinyou = 13,
    BJUpdateTypeBaiJiaLive = 14, // 云端课堂
    BJUpdateTypeBaiJiaApp = 15, // 百家 APP
    BJUpdateTypeBaiJiaLiveMeeting = 16 // 云端直播
};

@interface BJUpdateManager : NSObject

+ (instancetype)shareInstance;

/**
 *  @author LiangZhao, 16-08-26 11:08:45
 *
 *  检测升级
 *
 *  @param appType App类型，见BJUpdateType枚举
 *  @param channel 渠道号
 *  @param handle  更新回调
 */
- (void)checkUpdate:(BJUpdateType)appType
            channel:(NSString */* _Nullable */)channel
       updateHandle:(UpdateHandle)handle;
@end
