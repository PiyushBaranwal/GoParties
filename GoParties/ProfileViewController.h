//
//  ProfileViewController.h
//  GoParties
//
//  Created by GoParties on 05/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

#import "CAPSPageMenu.h"

#import "FeedViewController.h"
#import "AboutViewController.h"
#import "PartiesCreatedViewController.h"
#import "ReviewsViewController.h"
#import "FollowingViewController.h"
#import "FollowersViewController.h"
#import "PhotosViewController.h"
#import "VideosViewController.h"



@interface ProfileViewController : UIViewController<SWRevealViewControllerDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *profileTableView;
    
    
    IBOutlet UIButton *homeBtn;
    IBOutlet UIButton *myProfBtn;
    IBOutlet UIButton *myPartiesbtn;
    IBOutlet UIButton *myDealsBtn;
    
    IBOutlet UIButton *accessBtn;
    
    
    
    UIView *popUpView;
    UITextField  *locTextField;
    UITextField  *catTextField;
    UITextField  *typeTextField;
    
    UIImageView *locIcon;
    UIImageView *catIcon;
    UIImageView *typeIcon;
    
    UIView *cardView;
    UIImageView *bannerImg;
    UIScrollView *scrollView;
    
    UIButton *clickedBtn;
    UIPickerView *pickerView;
    
    NSMutableArray *locationArray;
    NSMutableArray *categoryArray;
    NSMutableArray *typeArray;
    
    
    //ViewPagerController *viewPager;
}

@property (nonatomic,retain) UIScrollView *scrollView;


@property (nonatomic,retain)IBOutlet UITableView *profileTableView;

@property (strong, nonatomic) SWRevealViewController *viewController;


//@property (nonatomic) NSUInteger numberOfTabs;


//- (IBAction)homeBtnClick:(id)sender;
//- (IBAction)myProfileBtnClick:(id)sender;
//- (IBAction)myPartiesBtnClick:(id)sender;
//- (IBAction)myDealsBtnClick:(id)sender;
//- (IBAction)accessBtnClick:(id)sender;


@end

