//
//  PartiesCalendarViewController.h
//  GoParties
//
//  Created by GoParties on 17/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"


@interface PartiesCalendarViewController : UIViewController<SWRevealViewControllerDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    
    IBOutlet UITableView *calendarTableView;
    UIView *popUpView;
    UITextField  *locTextField;
    UITextField  *catTextField;
    UITextField  *typeTextField;
    
    UIImageView *locIcon;
    UIImageView *catIcon;
    UIImageView *typeIcon;
    
    UIImageView *bannerImg;
    UIScrollView *scrollView;
    
    UIImageView *calBackImg;
    
    UIButton *bannerBtn;
    UIButton *followBtn;
    UILabel *followLbl;
    UIButton *bookMarkBtn;
    
    
    IBOutlet UIButton *homeBtn;
    IBOutlet UIButton *myProfBtn;
    IBOutlet UIButton *myPartiesbtn;
    IBOutlet UIButton *myDealsBtn;
    IBOutlet UIButton *accessBtn;
    
    
    UIButton *clickedBtn;
    UIPickerView *pickerView;
    
    NSMutableArray *locationArray;
    NSMutableArray *categoryArray;
    NSMutableArray *typeArray;
}
@property (strong, nonatomic) SWRevealViewController *viewController;
@property(nonatomic,retain)IBOutlet UITableView *calendarTableView;
@property (nonatomic,retain) UIScrollView *scrollView;





- (IBAction)homeBtnClick:(id)sender;
- (IBAction)myProfileBtnClick:(id)sender;
- (IBAction)myPartiesBtnClick:(id)sender;
- (IBAction)myDealsBtnClick:(id)sender;
- (IBAction)accessBtnClick:(id)sender;





@end
