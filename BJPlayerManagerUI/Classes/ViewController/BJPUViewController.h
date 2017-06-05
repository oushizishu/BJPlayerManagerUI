//
//  BJPUViewController.h
//  Pods
//
//  Created by DLM on 2017/4/26.
//
//

#import <UIKit/UIKit.h>
#import "BJPUViewControllerProtocol.h"

@interface BJPUViewController : UIViewController

@property (assign, nonatomic) CGRect smallScreenFrame;

- (void)playWithVid:(NSString *)vid type:(NSString *)type token:(NSString *)token;

@end
