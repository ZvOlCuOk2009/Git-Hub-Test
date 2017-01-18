//
//  TSDataSourse.h
//  Git Hub Test
//
//  Created by Mac on 19.01.17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSDataSourse : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *userID;

- (id)initWithServerResponse:(NSDictionary *)resposeDataSourse;

@end
