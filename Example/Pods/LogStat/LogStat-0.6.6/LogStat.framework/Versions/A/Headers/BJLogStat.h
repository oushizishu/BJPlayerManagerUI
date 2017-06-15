//
//  BJPageStatistics.h
//  BJEducation_student
//
//  Created by binluo on 15/10/31.
//  Copyright © 2015年 Baijiahulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJUpdate.h"

typedef struct {
    double latitude;
    double longitude;
} BJLocationCoordinate;


typedef NS_ENUM(NSUInteger, BJLogDevMode) {
    BJLogReleaseMode,
    BJLogTestMode,
};

typedef NS_ENUM(NSUInteger, BJLogAppType) {
    BJLogAppTypeStudent,
    BJLogAppTypeTeacher,
    BJLogAppTypeOrg,
    BJLogAppTypePubMed,
    BJLogAppTypeTianxiao,
    BJLogAppTypeLivePlayer,
    BJLogAppTypeVideoPlayer,
    BJLogAppTypeJinYou
};


typedef NS_ENUM(NSUInteger, BJLogReportPolicy) {
    BJLogReportPolicyRealTime,
    BJLogReportPolicyBatch,
};

typedef NS_ENUM(NSUInteger, BJLogPVReportType) {
    BJLogPVReportTypeBegin, // 默认
    BJLogPVReportTypeEnd 
};

typedef NS_ENUM(NSUInteger, BJLogPVAccessType) {
    BJLogPVAccessTypeNavigateForward,
    BJLogPVAccessTypeNavigateBackward,
    BJLogPVAccessTypeBackground,
    BJLogPageAccessTypeForward = BJLogPVAccessTypeNavigateForward /* DEPRECATED_ATTRIBUTE */,
    BJLogPageAccessTypeBackward = BJLogPVAccessTypeNavigateBackward /* DEPRECATED_ATTRIBUTE */
};
typedef BJLogPVAccessType BJLogPageAccessType /* DEPRECATED_ATTRIBUTE */;


@interface BJLogStat : NSObject

+ (void)setUUID:(NSString *)uuid;
+ (void)setDevMode:(BJLogDevMode)devMode;

/*
 * App激活渠道
 */
+ (void)setChannel:(NSString *)channel;

+ (void)setAppType:(BJLogAppType)appType;

+ (void)setUserID:(NSString *)userID;

+ (void)setCityID:(NSString *)cityID;

+ (void)setLocation:(BJLocationCoordinate)location;

+ (BOOL)started;
+ (void)startNotifier;

+ (void)setReportPolicy:(BJLogReportPolicy)reportPolicy;
+ (void)setBatchSize:(NSUInteger)batchSize;
+ (void)setReportTimeInterval:(NSTimeInterval)timeInterval;

+ (void)setCrashReportEnabled:(BOOL)flag __attribute__((deprecated("his method has been deprecated and will be removed in BJLogStat 0.3.1 .")));
                                                        
+ (void)setCrashMailEnabled:(BOOL)flag __attribute__((deprecated("This method has been deprecated and will be removed in BJLogStat 0.3.1 .")));

+ (void)setMailToRecipients:(NSArray *)mailToRecipients __attribute__((deprecated("This method has been deprecated and will be removed in BJLogStat 0.3.1 .")));

+ (void)setRootViewController:(UIViewController *)viewController __attribute__((deprecated("This method has been deprecated and will be removed in BJLogStat 0.3.1 .")));
@end

@interface BJLogStat(Event)

+ (void)event:(NSString *)eventId attributes:(NSDictionary *)attributes;
+ (void)event:(NSString *)eventId tag:(NSString *)tag attributes:(NSDictionary *)userAttributes;
+ (void)event:(NSString *)eventId tag:(NSString *)tag class:(NSString *)className attributes:(NSDictionary *)userAttributes;

@end


@interface BJLogStat(Page)

/**
 1. begin 上报模式（不支持上报 duration），例如先进入页面 A、再进入 B 页面：
 - 进入 A 时上报【(N/A) + A-begin】，离开 A 时记录 【A-end】
 - 进入 B 时上报【A-end + B-begin】，离开 B 时记录【B-end】
 - ........上报【B-end + C-begin】..........记录【C-end】
 - ........上报【prev-end + curr-begin】....记录【curr-end】
 2. end 上报模式，例如先进入页面 A、再进入 B 页面：
 - 进入 A 时记录【A-begin】，离开 A 时上报【(N/A) + A-begin + A-duration】、同时记录【A-end】
 - 进入 B 时记录【B-begin】，离开 B 时上报【A-end + B-begin + B-duration】、同时记录【B-end】
 - ........记录【C-begin】..........上报【B-end + C-begin + C-duration】.....记录【C-end】
 - ........记录【curr-begin】.......上报【prev-end + curr-begin + curr-duration】...记录【curr-end】
 3. bengin & end：
 - 分别在 `viewWillAppear:` 和 `viewWillDisappear:` 中调用
 - 如果上报页面停留时间 duration、并且要忽略掉进后台的时间，还需要分别在 `UIApplicationWillEnterForegroundNotification` 和 `UIApplicationDidEnterBackgroundNotification` 时调用
 ---- !!!: 在 `viewWillAppear:` 和 `viewWillDisappear:` 中注册、移除通知，而且要用 block 方式注册、避免移除时产生副作用
 - 离开时间 - 进入时间 = duration，单位毫秒
 */

+ (BJLogPVReportType)logPVReportType;
/** !!!: UI 显示之前设置上报模式，中途不要修改，否则可能造成数据混乱 */
+ (void)setLogPVReportType:(BJLogPVReportType)logPVReportType;

+ (void)beginLogPageView:(NSString *)pageName;
+ (void)beginLogPageView:(NSString *)pageName pageType:(NSString *)pageType sku:(NSString *)sku;
+ (void)beginLogPageView:(NSString *)pageName pageType:(NSString *)pageType sku:(NSString *)sku pageUrl:(NSString *)pageUrl;
+ (void)beginLogPageView:(NSString *)pageName pageType:(NSString *)pageType sku:(NSString *)sku pageUrl:(NSString *)pageUrl otherAttr:(NSDictionary *)attr;

+ (void)endLogPageView:(NSString *)pageName accessType:(BJLogPVAccessType)accessType;
+ (void)endLogPageView:(NSString *)pageName pageType:(NSString *)pageType;

@end
