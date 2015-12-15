//
//  RegisterViewController.h
//  GoParties
//
//  Created by GoParties on 19/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,GIDSignInDelegate,GIDSignInUIDelegate>

{
    IBOutlet UITextField *usertextField;
    IBOutlet UITextField *passTextField;
    IBOutlet UITextField *mobileTextFiled;
    IBOutlet UITextField *typeTextField;
    
    UIButton *clickedBtn;
    UIPickerView *pickerView;

    NSMutableArray *typeArray;
    IBOutlet UIButton *typeBtn;
    
    
   // NSMutableDictionary *mainDataDict;
    
    
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
    
    
    // for facebook
    NSString *facebookToken;
    NSString *facebookId;
    NSString *userFacebookMailId;
    NSString *userFacebookId;
    NSString *userFacebookPic;
    NSString *userFacebookProfileType;
    NSString *userFacebookName;
    
    
    
    // for google
    NSString *googleToken;
    NSString *googleId;
    NSString *userGoogleMailId;
    NSString *userGoogleId;
    NSString *userGooglePic;
    NSString *userGoogleProfileType;
    NSString *userGoogleName;

    
    NSString *webURL;
    
    
}
- (IBAction)typeBtnClick:(id)sender;
- (IBAction)regBtnClick:(id)sender;
- (IBAction)fbBtnClick:(id)sender;
- (IBAction)gpBtnClick:(id)sender;
- (IBAction)contAsGuestBtnClick:(id)sender;
//- (IBAction)haveAccBtnClick:(id)sender;
- (IBAction)loginBtnClick:(id)sender;
@end
