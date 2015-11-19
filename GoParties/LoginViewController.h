//
//  LoginViewController.h
//  GoParties
//
//  Created by GoParties on 18/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{
    IBOutlet UITextField *nameTextField;
    IBOutlet UITextField *passTextField;
}
- (IBAction)loginBtnClick:(id)sender;
- (IBAction)fbBtnClick:(id)sender;
- (IBAction)gpBtnClick:(id)sender;
- (IBAction)feelForgetBtnClick:(id)sender;
- (IBAction)regBtnClick:(id)sender;

@end
