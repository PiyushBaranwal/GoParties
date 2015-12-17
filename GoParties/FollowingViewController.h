//
//  FollowingViewController.h
//  GoParties
//
//  Created by GoParties on 05/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowingTableViewCell.h"

@interface FollowingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate>
{
    IBOutlet UITableView *followingTableView;
    IBOutlet FollowingTableViewCell *cell;
    
    
    IBOutlet UIImageView *iconImg;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *placeLbl;
    IBOutlet UIButton *followBtn;
    
    //For webservices
    NSMutableData *responseData;
    NSURLConnection *conn;
    NSMutableData *webData;
    NSString *responseString;
    
    NSMutableArray *json1;
    
    //fro parsing
    NSDictionary *json;
    NSMutableDictionary *mainDataDict;
    NSMutableArray *followingsArray;
    NSMutableArray *followingNameArray;
    NSMutableArray *followingPicArray;
    NSMutableArray *followingTypeArray;
    
    
}


@property (nonatomic,retain)IBOutlet UITableView *followingTableView;
@property (nonatomic,retain)IBOutlet FollowingTableViewCell *cell;


@end
