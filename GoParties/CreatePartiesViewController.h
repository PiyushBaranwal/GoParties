//
//  CreatePartiesViewController.h
//  GoParties
//
//  Created by GoParties on 17/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatePartiesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    IBOutlet UITableView *createPartiesTableView;
    
    
    UITextField *titletextField;
    UITextField *typetextField;
    UITextField *whentextField;
    UITextField *wheretextField;
    UITextField *uploadtextField;
    UITextField *termstextField;
    UITextField *nametextField;
    UITextField *desgntextField;
    UITextField *phonetextField;
    UITextField *partyThmtextField;
    UITextView *destextView;
    UITextField *specialtextField;
    
    
    UIButton *btnCouple;
    UIButton *btndrink;
    UIButton *btnother;
    UIButton *btncond;
    
    UIButton *typeBtn;
    UIButton *whenBtn;
    UIButton *whereBtn;
    UIButton *choseBtn;
    UIButton *termsBtn;
    UIButton *partyThemeBtn;
    UIButton *dealsBtn;
    
    
    UIButton *clickedBtn;
    UIPickerView *pickerView;
    
    NSMutableArray *locationArray;
    NSMutableArray *categoryArray;
    NSMutableArray *typeArray;
    
    UIView *popupView;
    UIView *picPopUpView;
    
    
    UIDatePicker *datePicker;
    UIAlertController *pickerViewPopup;
    

    
}


@property(nonatomic,retain) IBOutlet UITableView *createPartiesTableView;


@end
