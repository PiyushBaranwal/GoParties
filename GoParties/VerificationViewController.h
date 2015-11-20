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
    
}
- (IBAction)submitBtnClick:(id)sender;
- (IBAction)loginBtnClick:(id)sender;
- (IBAction)signupBtnClick:(id)sender;
@end
