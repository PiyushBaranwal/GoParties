//
//  FollowersViewController.h
//  GoParties
//
//  Created by GoParties on 05/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowersTableViewCell.h"



@interface FollowersViewController :UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *followersTableView;
    IBOutlet FollowersTableViewCell *cell;
    
    
    IBOutlet UIImageView *iconImg;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *placeLbl;
    IBOutlet UIButton *followBtn;
}


@property (nonatomic,retain)IBOutlet UITableView *followersTableView;
@property (nonatomic,retain)IBOutlet FollowersTableViewCell *cell;


@end
