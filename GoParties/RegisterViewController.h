//
//  RegisterViewController.h
//  GoParties
//
//  Created by GoParties on 19/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

{
    IBOutlet UITextField *usertextField;
    IBOutlet UITextField *passTextField;
    IBOutlet UITextField *mobileTextFiled;
    IBOutlet UITextField *typeTextField;
    
    UIButton *clickedBtn;
    UIPickerView *pickerView;

    NSMutableArray *typeArray;
    IBOutlet UIButton *typeBtn;
    
    
}
- (IBAction)typeBtnClick:(id)sender;
- (IBAction)regBtnClick:(id)sender;
- (IBAction)fbBtnClick:(id)sender;
- (IBAction)gpBtnClick:(id)sender;
- (IBAction)contAsGuestBtnClick:(id)sender;
//- (IBAction)haveAccBtnClick:(id)sender;
- (IBAction)loginBtnClick:(id)sender;
@end
