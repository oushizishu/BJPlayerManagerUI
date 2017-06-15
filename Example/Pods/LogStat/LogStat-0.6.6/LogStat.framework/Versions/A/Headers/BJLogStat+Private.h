//
//  BJLogStat+Private.h
//  BJEducation_student
//
//  Created by binluo on 15/11/17.
//  Copyright © 2015年 Baijiahulian. All rights reserved.
//

#import "BJLogStat.h"

@interface BJLogStat(Private)

+ (NSString *)devicePlatform;
+ (NSString *)deviceModel;
+ (NSString *)device_os;
+ (BOOL)isSimulator;
+ (BOOL)isJailbroken;

@end
