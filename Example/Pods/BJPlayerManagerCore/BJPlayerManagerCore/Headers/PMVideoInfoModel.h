//
//  PMVideoInfoModel.h
//  Pods
//
//  Created by DLM on 2016/11/14.
//
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import "PMVideoSectionModel.h"

typedef NS_ENUM(NSInteger, PMVideoDefinitionType){
    DT_LOW      = 0, //标清
    DT_HIGH     = 1, //高清
    DT_SUPPERHD = 2, //超清
    DT_720p     = 3, //720p
    DT_1080p    = 4, //1080p
};

typedef NS_ENUM(NSInteger, PMVideoWatermarkPos){
    PMVideoWatermarkPos_None      = 0, //不显示
    PMVideoWatermarkPos_LeftUp    = 1, //左上
    PMVideoWatermarkPos_RightUp   = 2, //右上
    PMVideoWatermarkPos_RightDown = 3, //右下
    PMVideoWatermarkPos_LeftDown  = 4, //左下
};

#pragma mark - PMVideoCDNInfoModel
@interface PMVideoCDNInfoModel : NSObject <YYModel>
@property (strong, nonatomic) NSString *cdn;
@property (strong, nonatomic) NSString *definition;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *encURL;
@property (strong, nonatomic) NSString *decURL;
@property (assign, nonatomic) NSUInteger duration;
@property (assign, nonatomic) NSUInteger size;
@property (assign, nonatomic) NSUInteger width;
@property (assign, nonatomic) NSUInteger height;
@property (assign, nonatomic) NSUInteger weight;

@end

@interface PMDefaultDefinitionInfoModel : NSObject <YYModel>
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *name;
@end

#pragma mark - PMVideoDefinitionInfoModel
@interface PMVideoDefinitionInfoModel : NSObject <YYModel>
@property (strong, nonatomic) NSArray<__kindof PMVideoCDNInfoModel*> *cdnList;
@property (strong, nonatomic) NSString *definition;
@property (assign, nonatomic) NSUInteger size;
@property (strong, nonatomic) NSString *definitionKey; //high,low,sueprHD
@property (assign, nonatomic) PMVideoDefinitionType definitionType;
@end

#pragma mark - PMVideoInfoModel
@interface PMVideoInfoModel : NSObject <YYModel>
@property (assign, nonatomic) long long videoId;
@property (assign, nonatomic) long long partnerId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *guid;
@property (strong, nonatomic) NSString *shotScreenImage;
@property (strong, nonatomic) NSString *startVideo;
@property (strong, nonatomic) NSString *endVideo;
@property (assign, nonatomic) NSUInteger duration;
@property (assign, nonatomic) NSUInteger reportInterval;

@property (strong, nonatomic) NSString *wartermarkUrl;
@property (assign, nonatomic) PMVideoWatermarkPos wartermarkPos;

@property (strong, nonatomic) NSArray <__kindof PMVideoDefinitionInfoModel*> *definitionList;
@property (strong, nonatomic) NSArray <__kindof PMDefaultDefinitionInfoModel*> *defaultDefinitionList;
@property (strong, nonatomic) NSArray<__kindof PMVideoSectionModel*> *sectionInfoList;
@end
