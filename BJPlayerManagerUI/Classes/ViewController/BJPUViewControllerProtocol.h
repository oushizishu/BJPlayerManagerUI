//
//  BJPUViewControllerProtocol.h
//  Pods
//
//  Created by DLM on 2017/4/26.
//
//

#import <Foundation/Foundation.h>
#import "BJPUMacro.h"

@protocol BJPUViewControllerProtocol <NSObject>

@required
- (void)changeScreenType:(BJPUScreenType)type;

@end
