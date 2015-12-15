//
//  PartyDetailViewController.h
//  GoParties
//
//  Created by GoParties on 15/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import "InfoViewController.h"
#import "LocationViewController.h"
#import "BookingViewController.h"
#import "CommentsViewController.h"
#import "InviteViewController.h"
#import "ProfileViewController.h"

#import "CAPSPageMenu.h"




@interface PartyDetailViewController : UIViewController<SWRevealViewControllerDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *partyDetailTableView;
    
    
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


@property (nonatomic,retain)IBOutlet UITableView *partyDetailTableView;

@property (strong, nonatomic) SWRevealViewController *viewController;


//@property (nonatomic) NSUInteger numberOfTabs;


- (IBAction)homeBtnClick:(id)sender;
- (IBAction)myProfileBtnClick:(id)sender;
- (IBAction)myPartiesBtnClick:(id)sender;
- (IBAction)myDealsBtnClick:(id)sender;
- (IBAction)accessBtnClick:(id)sender;

@end