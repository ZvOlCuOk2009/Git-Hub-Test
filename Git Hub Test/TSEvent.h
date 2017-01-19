//
//  TSEvent.h
//  Git Hub Test
//
//  Created by Mac on 19.01.17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSEvent : NSObject

@property (strong, nonatomic) NSString *titleLabel;
@property (strong, nonatomic) NSString *eventLabel;
@property (strong, nonatomic) NSURL *avatarURL;
@property (strong, nonatomic) NSString *htmlURL;

- (id)initWithServerResponse:(NSDictionary *)resposeObject;
- (id)initWithServerObject:(NSDictionary *)resposeObject;

@end
