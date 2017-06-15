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

typedef enum{
    DT_LOW      = 0, //标清
    DT_HIGH     = 1, //高清
    DT_SUPPERHD = 2, //超清
}PMVideoDefinitionType;

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
@property (strong, nonatomic) NSArray <__kindof PMVideoDefinitionInfoModel*> *definitionList;
@property (strong, nonatomic) NSArray<__kindof PMVideoSectionModel*> *sectionInfoList;
@end
