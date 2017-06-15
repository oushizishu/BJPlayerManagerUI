//
//  BJStatPersistence.h
//  BJEducation_student
//
//  Created by binluo on 15/11/3.
//  Copyright © 2015年 Baijiahulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJLogMessage.h"

@interface BJLogPersistence : NSObject

+ (instancetype)shareInstance;

- (BOOL)addLogMessage:(BJLogMessage *)message;

- (NSArray *)allMessages;

- (NSUInteger)countForMessages;

- (NSArray *)getMessages:(NSUInteger)batchSize;

- (BOOL)removeMessages:(NSArray *)messages;

@end
