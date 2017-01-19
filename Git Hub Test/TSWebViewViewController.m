//
//  TSWebViewViewController.m
//  Git Hub Test
//
//  Created by Mac on 19.01.17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "TSWebViewViewController.h"
#import "TSServerManager.h"

@interface TSWebViewViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TSWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getHtmlUrl];
}

#pragma mark - API

- (void)getHtmlUrl
{
    [[TSServerManager sharedManager] getHtmlUrl:self.htmlUrl onSuccess:^(NSString *htmlUrl) {
        if (htmlUrl) {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:htmlUrl]]];
        }
    } onFailure:^(NSError *error) {
        NSLog(@"error %@", error.localizedDescription);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
