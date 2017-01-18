//
//  TSMainViewController.m
//  Git Hub Test
//
//  Created by Mac on 18.01.17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "TSMainViewController.h"
#import "TSTableViewCell.h"
#import "TSServerManager.h"

@interface TSMainViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSArray *myDataSource;

@end

@implementation TSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++) {
        NSString *string = [NSString stringWithFormat:@"string %d", i];
        [self.dataSource addObject:string];
    }
    
    [[TSServerManager sharedManager] getDataOnByURL:^(NSArray *dataSource) {
        
        self.myDataSource = dataSource;
        
        NSDictionary *actor = [self.myDataSource objectAtIndex:0];
        
        NSURL *avatarUrl = [[actor objectForKey:@"actor"] objectForKey:@"avatar_url"];
        NSString *displayLogin = [[actor objectForKey:@"actor"]  objectForKey:@"display_login"];
        NSString *uid = [[actor objectForKey:@"actor"]  objectForKey:@"id"];
        NSString *login = [[actor objectForKey:@"actor"]  objectForKey:@"login"];
        NSURL *url = [[actor objectForKey:@"actor"]  objectForKey:@"url"];
        
    } onFailure:^(NSError *error) {
        
    }];
    
}
/*
{
    actor =     {
        "avatar_url" = "https://avatars.githubusercontent.com/u/22453207?";
        "display_login" = oh000024;
        "gravatar_id" = "";
        id = 22453207;
        login = oh000024;
        url = "https://api.github.com/users/oh000024";
    };
    "created_at" = "2017-01-18T23:33:52Z";
    id = 5176156220;
    payload =     {
        description = "MADD9022 Closures Assignment";
        "master_branch" = master;
        "pusher_type" = user;
        ref = master;
        "ref_type" = branch;
    };
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    
    TSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[TSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.titleLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    cell.detailLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    cell.avatarImageView.image = [UIImage imageNamed:@"featured_google"];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


@end
