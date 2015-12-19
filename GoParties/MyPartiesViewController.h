//
//  MyPartiesViewController.h
//  GoParties
//
//  Created by GoParties on 04/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPartiesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate>
{
    IBOutlet UITableView *myPartiesTableView;
    
    UISegmentedControl *segmentControl;
    
    UIImageView *bannerImg;
     UIScrollView *scrollView;
    
    //For webservices
    NSMutableData *responseData;
    NSURLConnection *conn;
    NSMutableData *webData;
    NSString *responseString;
    
    NSMutableArray *json1;
    
    //fro parsing
    NSDictionary *json;
    NSMutableDictionary *mainDataDict;
    NSMutableArray *partyBookmarkArray;
    NSMutableArray *partyTitleArray;
    NSMutableArray *partyDescArray;
    NSMutableArray *partybannerArray;
    NSMutableArray *partyAddArray;
    NSMutableArray *partyConPhoneArray;
    NSMutableArray *partyConEmailArray;
    NSMutableArray *partyConPersonArray;
    
    
    NSMutableDictionary *createdByDict;
    NSMutableArray *createdNameArray;
    NSMutableArray *cretaedProfilePicArray;
    NSMutableArray *createdProfileTypeArray;
    NSMutableArray *createdRatingArray;
    
    NSMutableArray *partiesArray;
    
    
}


@property (nonatomic,retain) UIScrollView *scrollView;

@property (nonatomic,retain)IBOutlet UITableView *myPartiesTableView;
@end
