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
#import "TSEvent.h"
#import "UIImageView+AFNetworking.h"
#import "TSWebViewViewController.h"

@interface TSMainViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation TSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestDataFromTheServer];
}


- (IBAction)refreshPressedButton:(id)sender
{
    [self requestDataFromTheServer];
}

#pragma mark - API

- (void)requestDataFromTheServer
{
    [[TSServerManager sharedManager] getDataOnByURL:^(NSArray *dataSource) {
        
        self.dataSource = [NSArray arrayWithArray:dataSource];
        [self.tableView reloadData];
        
    } onFailure:^(NSError *error) {
        NSLog(@"error %@", error.localizedDescription);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

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
    
    TSEvent *event = [self.dataSource objectAtIndex:indexPath.row];
    cell.titleLabel.text = event.titleLabel;
    cell.detailLabel.text = [NSString stringWithFormat:@"%@ %@", event.eventLabel, [self getCurrentData]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:event.avatarURL];
    
    __weak UITableViewCell *weakCell = cell;
    cell.imageView.image = nil;
    
    [cell.imageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"avatar-placeholder"]
                                   success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                       weakCell.imageView.image = image;
                                   } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                       NSLog(@"error %@", error.localizedDescription);
                                   }];
    [self getCurrentData];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TSWebViewViewController *controller =
    [self.storyboard instantiateViewControllerWithIdentifier:@"TSWebViewViewController"];
    TSEvent *event = [self.dataSource objectAtIndex:indexPath.row];
    controller.htmlUrl = event.htmlURL;
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - data

- (NSString *)getCurrentData
{
    NSLocale* currentLocale = [NSLocale currentLocale];
    [[NSDate date] descriptionWithLocale:currentLocale];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentData = [dateFormatter stringFromDate:[NSDate date]];
    return currentData;
}

@end
