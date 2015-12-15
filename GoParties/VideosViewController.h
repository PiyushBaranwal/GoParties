//
//  VideosViewController.h
//  GoParties
//
//  Created by GoParties on 15/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface VideosViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SWRevealViewControllerDelegate,NSURLConnectionDelegate>
{
    IBOutlet UITableView *videoTableView;
    
    IBOutlet UIButton *homeBtn;
    IBOutlet UIButton *myProfBtn;
    IBOutlet UIButton *myPartiesbtn;
    IBOutlet UIButton *myDealsBtn;
    
    IBOutlet UIButton *accessBtn;
    
}
@property (nonatomic,retain) IBOutlet UITableView *videoTableView;


- (IBAction)homeBtnClick:(id)sender;
- (IBAction)myProfileBtnClick:(id)sender;
- (IBAction)myPartiesBtnClick:(id)sender;
- (IBAction)myDealsBtnClick:(id)sender;
- (IBAction)accessBtnClick:(id)sender;

@end
