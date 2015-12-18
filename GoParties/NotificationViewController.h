//
//  NotificationViewController.h
//  GoParties
//
//  Created by GoParties on 17/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "NotificationTableViewCell.h"

@interface NotificationViewController : UIViewController<SWRevealViewControllerDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate>
{
    
    IBOutlet UITableView *notificationTabelView;
     IBOutlet NotificationTableViewCell *cell;
    
    
    IBOutlet UIImageView *iconImg;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *placeLbl;
    
    
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
    
}

@property(nonatomic,retain)IBOutlet UITableView *notificationTabelView;
@property (nonatomic,retain)IBOutlet NotificationTableViewCell *cell;

@property (strong, nonatomic) SWRevealViewController *viewController;

@end
