//
//  LoginViewController.h
//  GoParties
//
//  Created by GoParties on 18/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


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
