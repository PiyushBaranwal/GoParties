//
//  LoginViewController.h
//  GoParties
//
//  Created by GoParties on 18/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

//#import "MBProgressHUD.h"


@interface LoginViewController : UIViewController<UITextFieldDelegate,NSURLConnectionDelegate,CLLocationManagerDelegate>
{
    
   
    
    
    IBOutlet UITextField *nameTextField;
    IBOutlet UITextField *passTextField;
    
    
    //For webservices
    NSMutableData *responseData;
    NSURLConnection *conn;
    NSMutableData *webData;
    NSString *responseString;
    
     NSMutableArray *json1;
    
    //fro parsing
    NSDictionary *json;
    NSMutableDictionary *mainDataDict;
    NSMutableDictionary *userDict;
    
    // variables used to store the user information
    NSString *userAddress;
    NSString *userCityId;
    NSString *userContactEmail;
    NSString *userContactPerson;
    NSString *userContactPhone;
    NSString *userCoverImg;
    NSString *userCreatedAt;
    NSString *userDeleatedAt;
    NSString *userEmail;
    NSString *userFBId;
    NSString *userFBPageId;
    NSMutableArray *userFollowdataArray;
    NSString *userGPId;
    NSString *userId;
    BOOL userIsActive;
    NSString *userLat1;
    NSString *userLong1;
    NSMutableArray *userPartyData;
    NSString *name;
    NSString *userOTP;
    NSString *userPassword;
    NSString *userPhone;
    NSString *userProfilePic;
    NSString *userProfileType;
    NSString *userRating;
    NSString *userReportCount;
    NSString *userName;
    NSString *userValidEmail;
    NSString *userValidPhone;
    NSString *userWebSite;
   
    BOOL logged;
    
    
//    CLLocationManager *locManager;
//    float curLat;
//    float curLong;
    
    
    
}

//@property(nonatomic,strong)CLLocationManager *locManager;


- (IBAction)loginBtnClick:(id)sender;
- (IBAction)fbBtnClick:(id)sender;
- (IBAction)gpBtnClick:(id)sender;
- (IBAction)feelForgetBtnClick:(id)sender;
//- (IBAction)regBtnClick:(id)sender;
- (IBAction)signupBtnClick:(id)sender;

@end
