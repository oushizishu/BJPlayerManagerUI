//
//  PMVideoSectionModel.h
//  Pods
//
//  Created by DLM on 2016/12/6.
//
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

@interface PMVideoSectionModel : NSObject <YYModel>

@property (assign, nonatomic) NSInteger serialNumber;
@property (assign, nonatomic) NSInteger videoId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *playURL;

@end


