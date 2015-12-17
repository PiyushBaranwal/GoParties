//
//  FeedViewController.h
//  GoParties
//
//  Created by GoParties on 05/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KASlideShow.h"


@interface FeedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,KASlideShowDelegate,NSURLConnectionDelegate>
{
    IBOutlet UITableView *feedTableView;
    
    
    //For webservices
    NSMutableData *responseData;
    NSURLConnection *conn;
    NSMutableData *webData;
    NSString *responseString;
    
    NSMutableArray *json1;
    
    //fro parsing
    NSDictionary *json;
    NSMutableDictionary *mainDataDict;
    NSMutableArray *postDataArray;
    NSMutableDictionary *postedByDict;
    NSMutableArray *likeCountArray;
    NSMutableArray *commentsCountArray;
    NSMutableArray *shareCountArray;
    NSMutableArray *postTypeArray;
    NSMutableArray *postTextArray;
    NSMutableArray *postPhotoArray;
    NSMutableArray *postVideoArray;
    NSMutableArray *postedAtArray;
    NSMutableArray *profileIdArray;
    NSMutableArray *profileNameArray;
    NSMutableArray *profilePicArray;
    NSMutableArray *profileTypeArray;
}

@property (nonatomic,retain)IBOutlet UITableView *feedTableView;
@property (strong,nonatomic) IBOutlet KASlideShow * slideshow;


@end
