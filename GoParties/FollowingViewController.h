//
//  FollowingViewController.h
//  GoParties
//
//  Created by GoParties on 05/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowingTableViewCell.h"

@interface FollowingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *followingTableView;
    IBOutlet FollowingTableViewCell *cell;
    
    
    IBOutlet UIImageView *iconImg;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *placeLbl;
    IBOutlet UIButton *followBtn;
}


@property (nonatomic,retain)IBOutlet UITableView *followingTableView;
@property (nonatomic,retain)IBOutlet FollowingTableViewCell *cell;


@end
