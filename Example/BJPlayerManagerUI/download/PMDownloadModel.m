//
//  PMDownloadModel.m
//  BJPlayerManagerCore
//
//  Created by 辛亚鹏 on 2017/6/19.
//  Copyright © 2017年 oushizishu. All rights reserved.
//

#import "PMDownloadModel.h"

@implementation PMDownloadModel
/*
 - (NSString *)stateString;
 {
 NSString *str = @"未知";
 switch (self.state) {
 case 0:
 str = @"下载中";
 break;
 
 case 1:
 str = @"暂停";
 break;
 
 case 2:
 str = @"完成";
 break;
 
 case 3:
 str = @"取消";
 break;
 
 case 4:
 str = @"失败";
 break;
 default:
 break;
 }
 return str;
 }
 */

- (NSString *)modelIdfi {
    return [NSString stringWithFormat:@"%@%li", self.vid, self.definitionType];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.vid forKey:@"vid"];
    [aCoder encodeObject:self.filePath forKey:@"filePath"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.modelIdfi forKey:@"modelIdfi"];
    
    [aCoder encodeInteger:self.definitionType forKey:@"definitionType"];
    [aCoder encodeInteger:self.receiveSize forKey:@"receiveSize"];
    [aCoder encodeInteger:self.totalSize forKey:@"totalSize"];
    [aCoder encodeInteger:self.state forKey:@"state"];
    [aCoder encodeInteger:self.progress forKey:@"progress"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _vid = [aDecoder decodeObjectForKey:@"vid"];
        _filePath = [aDecoder decodeObjectForKey:@"filePath"];
        _token = [aDecoder decodeObjectForKey:@"token"];
        _modelIdfi = [aDecoder decodeObjectForKey:@"modelIdfi"];
        
        _definitionType = [aDecoder decodeIntegerForKey:@"definitionType"];
        _receiveSize = [aDecoder decodeIntegerForKey:@"receiveSize"];
        _totalSize = [aDecoder decodeIntegerForKey:@"totalSize"];
        _state = [aDecoder decodeIntegerForKey:@"state"];
        _progress = [aDecoder decodeIntegerForKey:@"progress"];
    }
    return self;
}

@end
