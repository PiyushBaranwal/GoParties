//
//  SearchPartiesViewController.h
//  GoParties
//
//  Created by GoParties on 17/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface SearchPartiesViewController : UIViewController<SWRevealViewControllerDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate,UIDocumentInteractionControllerDelegate,NSURLConnectionDelegate>
{
    IBOutlet UITableView *searchTableView;
    
    
    IBOutlet UIButton *homeBtn;
    IBOutlet UIButton *myProfBtn;
    IBOutlet UIButton *myPartiesbtn;
    IBOutlet UIButton *myDealsBtn;
    IBOutlet UIButton *accessBtn;
    
    
    BOOL followBtnClicked;
    
    UIButton *bannerBtn;
    UIButton *followBtn;
    
    UIView *popUpView;
    UITextField  *locTextField;
    UITextField  *catTextField;
    UITextField  *typeTextField;
    
    UIImageView *locIcon;
    UIImageView *catIcon;
    UIImageView *typeIcon;
    
    
    UIImageView *bannerImg;
    UIScrollView *scrollView;
    
    UIButton *clickedBtn;
    UIPickerView *pickerView;
    
    NSMutableArray *locationArray;
    NSMutableArray *categoryArray;
    NSMutableArray *typeArray;
    
    NSString *currentDateStr;
    
    //For webservices
    NSMutableData *responseData;
    NSURLConnection *conn;
    NSMutableData *webData;
    NSString *responseString;
    
    NSMutableArray *json1;
    
    //fro parsing
    NSDictionary *json;
    NSMutableDictionary *mainDataDict;
    NSMutableArray *partiesArray;
    NSMutableDictionary *partyDict;
    NSMutableArray *bookmarkArray;
    NSMutableArray *followingArray;
    NSMutableArray *partyTitleArray;
    NSMutableArray *partyAddArray;
    NSMutableArray *partyPlaceLatArray;
    NSMutableArray *partyPlaceLongArray;
    NSMutableArray *partyBannerArray;
    NSMutableArray *partyIdArray;
    NSMutableArray *partyDescArray;
    
    
    
    
    
    NSString *userLatStr;
    NSString *userLongStr;
    
    
    NSInteger clickedBtnTagValue;
}

@property (nonatomic,retain) UIScrollView *scrollView;


@property (nonatomic,retain)IBOutlet UITableView *searchTableView;

@property (strong, nonatomic) SWRevealViewController *viewController;
@property (nonatomic,assign)NSInteger clickedBtnTagValue;

@property (retain) UIDocumentInteractionController * documentInteractionController;

- (IBAction)homeBtnClick:(id)sender;
- (IBAction)myProfileBtnClick:(id)sender;
- (IBAction)myPartiesBtnClick:(id)sender;
- (IBAction)myDealsBtnClick:(id)sender;
- (IBAction)accessBtnClick:(id)sender;

@end
