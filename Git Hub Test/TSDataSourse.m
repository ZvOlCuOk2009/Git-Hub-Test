//
//  TSDataSourse.m
//  Git Hub Test
//
//  Created by Mac on 19.01.17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "TSDataSourse.h"

@implementation TSDataSourse

- (id)initWithServerResponse:(NSDictionary *)resposeDataSourse
{
    self = [super init];
    if (self) {
        self.userID = [resposeDataSourse objectForKey:@"uid"];
        self.firstName = [resposeDataSourse objectForKey:@"first_name"];
        self.lastName = [resposeDataSourse objectForKey:@"last_name"];
        self.date = [resposeDataSourse objectForKey:@"bdate"];
    }
    return self;
}

@end
