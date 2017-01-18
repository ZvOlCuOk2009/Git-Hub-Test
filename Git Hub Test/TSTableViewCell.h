//
//  TSTableViewCell.h
//  Git Hub Test
//
//  Created by Mac on 18.01.17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end
