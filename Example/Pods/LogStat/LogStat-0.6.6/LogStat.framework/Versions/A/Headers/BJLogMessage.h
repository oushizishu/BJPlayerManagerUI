//
//  BJLogMessage.h
//  BJEducation_student
//
//  Created by binluo on 15/11/4.
//  Copyright © 2015年 Baijiahulian. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, BJLogEventType) {
    BJLogEventTypePage = 1,
    BJLogEventTypeClick = 2,
};


@interface BJLogMessage : NSObject<NSCopying>

@property (nonatomic, assign) BJLogEventType eventType;
@property (nonatomic, assign) long long event_time;
@property (nonatomic, strong) NSDictionary *event_attr;

@property (nonatomic, copy) NSString *device_id;
@property (nonatomic, copy) NSString *device_platform;
@property (nonatomic, copy) NSString *device_os;
@property (nonatomic, copy) NSString *device_model;
@property (nonatomic, assign) BOOL jail_break;

@property (nonatomic, copy) NSString *app_type;
@property (nonatomic, copy) NSString *app_terminal;
@property (nonatomic, copy) NSString *app_version;
@property (nonatomic, copy) NSString *app_channel;
@property (nonatomic, assign) NSInteger app_test;

@property (nonatomic, copy) NSString *user_role;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *user_city_id;
@property (nonatomic, assign) CGFloat user_longitude;
@property (nonatomic, assign) CGFloat user_latitude;


- (NSDictionary *)toDictionary;

@end
