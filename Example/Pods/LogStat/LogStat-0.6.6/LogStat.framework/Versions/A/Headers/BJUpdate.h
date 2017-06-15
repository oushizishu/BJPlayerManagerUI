//
//  BJUpdate.h
//  Pods
//
//  Created by Mac_ZL on 16/8/26.
//
//

#import <Foundation/Foundation.h>
#import "BJUpdateManager.h"

@interface BJUpdate : NSObject

/**
 *  @author LiangZhao, 16-08-26 11:08:45
 *
 *  检测升级
 *
 *  @param appType App类型，见BJUpdateType枚举
 *  @param channel 渠道号
 *  @param handle  更新回调
 */
+(void)checkUpdate:(BJUpdateType )appType
           channel:(NSString *)channel
      updateHandle:(UpdateHandle) handle;
@end
