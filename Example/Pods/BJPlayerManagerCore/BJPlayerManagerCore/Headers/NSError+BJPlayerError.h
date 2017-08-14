//
//  NSError+BJPlayerError.h
//  Pods
//
//  Created by DLM on 2017/2/15.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BJPMErrorCode) {
    BJPMErrorCodeLoading = 1000,//加载中
    BJPMErrorCodeLoadingEnd,    //加载完成
    BJPMErrorCodeParse,         //视频解析错误
    BJPMErrorCodeNetwork,       //网络错误
    BJPMErrorCodeWWAN,          //非WIFI环境，这时要暂停，并提示
    BJPMErrorCodeWIFI,
    BJPMErrorCodeServer,        //server端返回的错误
};

#define BJPMErrorDomain  @"BJPMErrorDomain"

@interface NSError (BJPlayerError)

+ (NSError *)errorWithErrorCode:(BJPMErrorCode)code;

+ (NSError *)errorWithErrorCode:(BJPMErrorCode)code message:(NSString *)msg;

+ (NSError *)errorWithErrorCode:(BJPMErrorCode)code andError:(NSError *)error;

@end
