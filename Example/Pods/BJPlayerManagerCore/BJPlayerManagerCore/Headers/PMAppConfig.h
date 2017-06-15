//
//  PMAppConfig.h
//  Pods
//
//  Created by DLM on 2016/10/25.
//
//

#import <Foundation/Foundation.h>

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

typedef NS_ENUM (NSInteger, PMDeployType){
    PMDeployType_test,
    PMDeployType_dev,
    PMDeployType_beta,
    PMDeployType_www,
    PMDeployType_mock,
    _NCDeployType_count
};

@interface PMAppConfig : NSObject

+ (void)initializeInstance;
+ (instancetype)sharedInstance;

#if DEBUG
@property (nonatomic) PMDeployType deployType;
#else
//@property (nonatomic) PMDeployType deployType;
#endif

@property (nonatomic, readonly) NSString *baseURLString;


/**
 合作伙伴id
 */
@property (nonatomic, copy) NSString *partnerId;

/**
 token
 */
@property (nonatomic) NSString *authToken;

@end
