//
//  FollowersViewController.h
//  GoParties
//
//  Created by GoParties on 05/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowersTableViewCell.h"



@interface FollowersViewController :UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate>
{
    IBOutlet UITableView *followersTableView;
    IBOutlet FollowersTableViewCell *cell;
    
    
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
    NSMutableArray *followersArray;
    NSMutableArray *followerNameArray;
    NSMutableArray *followerPicArray;
    NSMutableArray *followerTypeArray;
}


@property (nonatomic,retain)IBOutlet UITableView *followersTableView;
@property (nonatomic,retain)IBOutlet FollowersTableViewCell *cell;


@end
