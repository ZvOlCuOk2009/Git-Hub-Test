//
//  TSServerManager.h
//  Git Hub Test
//
//  Created by Mac on 19.01.17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#import "TSDataSourse.h"

@interface TSServerManager : NSObject

+ (TSServerManager *)sharedManager;
- (void)getDataOnByURL:(void(^)(NSArray *dataSource))success onFailure:(void(^)(NSError *error))failure;

@end
