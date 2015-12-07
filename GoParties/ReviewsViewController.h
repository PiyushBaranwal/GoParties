//
//  ReviewsViewController.h
//  GoParties
//
//  Created by GoParties on 05/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface ReviewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    IBOutlet UITableView *reviewsTableView;
    
}

@property(nonatomic,retain)IBOutlet UITableView *reviewsTableView;

@end