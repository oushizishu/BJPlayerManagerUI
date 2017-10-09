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
 用来设置是否需要片头和片尾广告, 默认没有广告
 
 yes: 设置为yes的时候, 需要后台配置广告url, 才会有广告, 如果后台没有配置广告的url, 也是没有广告的
 no:  没有广告
 */
@property (nonatomic, assign) BOOL isNeedAD;


@end
