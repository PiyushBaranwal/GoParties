//
//  ResetViewController.h
//  GoParties
//
//  Created by GoParties on 10/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetViewController : UIViewController<UITextFieldDelegate,NSURLConnectionDelegate>
{
    
    IBOutlet UITextField *verifyTextField;
    IBOutlet UITextField *newpasswordTextField;
    
    
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
    
    NSString *mobStr;
    NSString *mailStr;

}

@property (nonatomic,retain)NSString *mobStr;
@property(nonatomic,retain)NSString *mailStr;

- (IBAction)submitBtnClick:(id)sender;

- (IBAction)loginBtnClick:(id)sender;
- (IBAction)signUpBtnClick:(id)sender;

@end
