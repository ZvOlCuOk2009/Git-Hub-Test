//
//  TSEvent.m
//  Git Hub Test
//
//  Created by Mac on 19.01.17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "TSEvent.h"

@implementation TSEvent

- (id)initWithServerResponse:(NSDictionary *)resposeObject
{
    self = [super init];
    if (self) {
        self.titleLabel = [[resposeObject objectForKey:@"actor"] objectForKey:@"display_login"];
        self.eventLabel = [resposeObject objectForKey:@"type"];
        NSString *urlStringAvatar = [[resposeObject objectForKey:@"actor"] objectForKey:@"avatar_url"];
        if (urlStringAvatar) {
            self.avatarURL = [NSURL URLWithString:urlStringAvatar];
        }
        self.htmlURL = [[resposeObject objectForKey:@"actor"] objectForKey:@"url"];
    }
    return self;
}

- (id)initWithServerObject:(NSDictionary *)resposeObject
{
    self = [super init];
    if (self) {
        self.htmlURL = [resposeObject objectForKey:@"html_url"];
    }
    return self;
}

@end
