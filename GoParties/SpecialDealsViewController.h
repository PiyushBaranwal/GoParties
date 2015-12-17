//
//  SpecialDealsViewController.h
//  GoParties
//
//  Created by GoParties on 17/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface SpecialDealsViewController : UIViewController<SWRevealViewControllerDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate>
{
    IBOutlet UITableView *dealsTableView;
    
    
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
    
    
    
    UIButton *clickedBtn;
    UIPickerView *pickerView;
    
    NSMutableArray *locationArray;
    NSMutableArray *categoryArray;
    NSMutableArray *typeArray;
    
    
    
    
    //For webservices
    NSMutableData *responseData;
    NSURLConnection *conn;
    NSMutableData *webData;
    NSString *responseString;
    
    NSMutableArray *json1;
    
    //fro parsing
    NSDictionary *json;
    NSMutableDictionary *mainDataDict;
    NSMutableArray *dealsArray;
    NSMutableArray *dealsByArray;
    NSMutableDictionary *dealsByDict;

}

@property (nonatomic,retain)IBOutlet UITableView *dealsTableView;

@property (strong, nonatomic) SWRevealViewController *viewController;



- (IBAction)homeBtnClick:(id)sender;
- (IBAction)myProfileBtnClick:(id)sender;
- (IBAction)myPartiesBtnClick:(id)sender;
- (IBAction)myDealsBtnClick:(id)sender;
- (IBAction)accessBtnClick:(id)sender;



@end
