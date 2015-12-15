//
//  VerificationViewController.h
//  GoParties
//
//  Created by GoParties on 20/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerificationViewController : UIViewController<UITextFieldDelegate>

{
    IBOutlet UITextField *verificationTextField;
    
    NSMutableDictionary *mainDataDict;
    NSMutableDictionary *userDict;
    
    NSString *mailId;
    
    NSString *webURL;
    BOOL logged;
    
}


@property (nonatomic,retain) NSString *mailId;


- (IBAction)submitBtnClick:(id)sender;
- (IBAction)loginBtnClick:(id)sender;
- (IBAction)signupBtnClick:(id)sender;
- (IBAction)resendOTPBtnClick:(id)sender;
@end
