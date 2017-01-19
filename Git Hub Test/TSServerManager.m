//
//  TSServerManager.m
//  Git Hub Test
//
//  Created by Mac on 19.01.17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "TSServerManager.h"
#import "TSEvent.h"

@interface TSServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation TSServerManager

+ (TSServerManager *)sharedManager {
    
    static TSServerManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TSServerManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sessionManager = [[AFHTTPSessionManager alloc] init];
    }
    return self;
}

#pragma mark - Methods API

- (void)getDataOnByURL:(void(^)(NSArray *dataSource))success onFailure:(void(^)(NSError *error)) failure {
    
    [self.sessionManager GET:@"https://api.github.com/events"
                  parameters:nil
                    progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        NSMutableArray *objectArray = [NSMutableArray array];
                        for (NSDictionary *dictionary in responseObject) {
                            TSEvent *event = [[TSEvent alloc] initWithServerResponse:dictionary];
                            [objectArray addObject:event];
                        }
                        if (success) {
                            success(objectArray);
                        }
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        if (failure) {
                            failure(error);
                        }
                    }];

}

- (void)getHtmlUrl:(NSString *)url onSuccess:(void(^)(NSString *htmlUrl))success onFailure:(void(^)(NSError *error))failure
{
    [self.sessionManager GET:url
                  parameters:nil
                    progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        TSEvent *event = [[TSEvent alloc] initWithServerObject:responseObject];
                        NSString *html = event.htmlURL;
                        
                        if (success) {
                            success(html);
                        }
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        if (failure) {
                            failure(error);
                        }
                    }];

}

@end
