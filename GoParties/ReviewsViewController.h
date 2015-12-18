//
//  ReviewsViewController.h
//  GoParties
//
//  Created by GoParties on 05/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface ReviewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,NSURLConnectionDelegate>
{
    IBOutlet UITableView *reviewsTableView;
    
    
    //For webservices
    NSMutableData *responseData;
    NSURLConnection *conn;
    NSMutableData *webData;
    NSString *responseString;
    
    NSMutableArray *json1;
    
    //fro parsing
    NSDictionary *json;
    NSMutableDictionary *mainDataDict;
    NSMutableArray *reviewsArray;
    NSMutableDictionary *reviewByDict;
    NSMutableArray *revByNameArray;
    NSMutableArray *revByRatingArray;
    NSMutableArray *revByReviewArray;
    NSMutableArray *revByProfilePicArray;
    NSMutableArray *revByProfileTypeArray;
    
    

    
}

@property(nonatomic,retain)IBOutlet UITableView *reviewsTableView;

@end