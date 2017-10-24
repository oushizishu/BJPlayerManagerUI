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
@property (assign, nonatomic) BJPUScreenType screenType;

- (void)playWithVid:(NSString *)vid token:(NSString *)token;

- (void)playWithVideoPath:(NSString *)path definitionType:(NSInteger)definitionType;

/**
 进度条是否可以拖拽
 
 @param mayDrag mayDrag
 */
- (void)sliderMayDrag:(BOOL)mayDrag;

@end
