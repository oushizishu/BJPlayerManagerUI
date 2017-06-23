//
//  PMDownloadModel.h
//  BJPlayerManagerCore
//
//  Created by 辛亚鹏 on 2017/6/19.
//  Copyright © 2017年 oushizishu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMDownloadModel : NSObject <NSCoding>

@property (nonatomic) NSUInteger receiveSize;
@property (nonatomic) NSUInteger totalSize;
@property (nonatomic) CGFloat progree;
@property (nonatomic) NSInteger state;

@property (nonatomic) NSString *filePath;

@property (nonatomic) NSString *vid;
@property (nonatomic) NSString *token;
@property (nonatomic) NSInteger definitionType;

@property (nonatomic) NSString *modelIdfi;

//- (NSString *)stateString;

@end
