//
//  PartiesNearYouViewController.h
//  GoParties
//
//  Created by GoParties on 17/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface PartiesNearYouViewController : UIViewController<SWRevealViewControllerDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *partiesTableView;
    
    UIButton *bannerBtn;
    
    UIView *popUpView;
    UITextField  *locTextField;
    UITextField  *catTextField;
    UITextField  *typeTextField;
    
    UIImageView *locIcon;
    UIImageView *catIcon;
    UIImageView *typeIcon;
    
    
    UIImageView *bannerImg;
    UIScrollView *scrollView;
    
    UIButton *clickedBtn;
    UIPickerView *pickerView;
    
    NSMutableArray *locationArray;
    NSMutableArray *categoryArray;
    NSMutableArray *typeArray;
    
    NSString *currentDateStr;
}

@property (nonatomic,retain) UIScrollView *scrollView;


@property (nonatomic,retain)IBOutlet UITableView *partiesTableView;

@property (strong, nonatomic) SWRevealViewController *viewController;
@end
