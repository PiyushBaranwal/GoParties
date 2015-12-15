//
//  HomeViewController.h
//  GoParties
//
//  Created by GoParties on 16/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "KASlideShow.h"
#import <GoogleSignIn/GoogleSignIn.h>

@interface HomeViewController : UIViewController<SWRevealViewControllerDelegate,KASlideShowDelegate,GIDSignInDelegate,GIDSignInUIDelegate>
{
    IBOutlet UIButton *loginBtn;
    IBOutlet UIButton *signUpBtn;
    
    
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

@property(nonatomic,retain) IBOutlet UIButton *loginBtn;
@property(nonatomic,retain)IBOutlet UIButton *signUpBtn;


@property (strong, nonatomic) SWRevealViewController *viewController;
@property (strong,nonatomic) IBOutlet KASlideShow * slideshow;

- (IBAction)loginBtnClick:(id)sender;
- (IBAction)signUpBtnClick:(id)sender;
- (IBAction)fbBtnClick:(id)sender;
- (IBAction)gpBtnClick:(id)sender;
- (IBAction)continueAsGuestBtnClick:(id)sender;


@end
