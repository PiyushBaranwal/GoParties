//
//  FogetPassViewController.h
//  GoParties
//
//  Created by GoParties on 20/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FogetPassViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *userTextField;
    IBOutlet UITextField *mobileTextField;
    
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

    
}
- (IBAction)submitBtnClick:(id)sender;
- (IBAction)loginBtnClick:(id)sender;
- (IBAction)signUpBtnClick:(id)sender;

@end
