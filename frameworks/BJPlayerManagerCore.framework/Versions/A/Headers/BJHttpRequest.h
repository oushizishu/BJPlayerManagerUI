//
//  BJHttpRequest.h
//  Pods
//
//  Created by 辛亚鹏 on 2017/9/19.
//
//

#import <Foundation/Foundation.h>

@class BJHttpRequest;

@protocol BJHttpRequestDelegate <NSObject>

- (void)requestFailed:(BJHttpRequest *)request;
- (void)requestStarted:(BJHttpRequest *)request;
- (void)request:(BJHttpRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders;
- (void)request:(BJHttpRequest *)request didReceiveBytes:(long long)bytes;
- (void)requestFinished:(BJHttpRequest *)request;
@optional
- (void)request:(BJHttpRequest *)request willRedirectToURL:(NSURL *)newURL;

@end

@interface BJHttpRequest : NSObject
@property (weak, nonatomic  ) id<BJHttpRequestDelegate> delegate;
@property (strong, nonatomic) NSURL                  *url;
@property (strong, nonatomic) NSURL                  *originalURL;

/** key = @"File", value为BJFileModel对象, {@"File : BJFileModel"} */
@property (strong, nonatomic) NSDictionary           *userInfo;
@property (assign, nonatomic) NSInteger              tag;
@property (copy, nonatomic) NSString                 *downloadDestinationPath;
@property (copy, nonatomic) NSString                 *temporaryFileDownloadPath;
@property (strong,readonly,nonatomic) NSError *error;

- (instancetype)initWithURL:(NSURL*)url;
- (void)startAsynchronous;
- (BOOL)isFinished;
- (BOOL)isExecuting;
- (void)cancel;

@end
