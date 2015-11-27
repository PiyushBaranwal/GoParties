//
//  MainViewController.h
//  GoParties
//
//  Created by GoParties on 19/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "KASlideShow.h"

@interface MainViewController : UIViewController<SWRevealViewControllerDelegate,KASlideShowDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

{
    IBOutlet UITableView *listTableView;
    
    NSMutableArray *iconImgArray;
    NSMutableArray *titleArray;
    NSMutableArray *descArray;
    
    UIView *popUpView;
    UITextField  *locTextField;
    UITextField  *catTextField;
    UITextField  *typeTextField;
    
    UIImageView *locIcon;
    UIImageView *catIcon;
    UIImageView *typeIcon;
    
    
    
    UIButton *clickedBtn;
    UIPickerView *pickerView;
    
    NSMutableArray *locationArray;
    NSMutableArray *categoryArray;
    NSMutableArray *typeArray;
    
    UIButton *btn;
}


@property (nonatomic,retain)IBOutlet UITableView *listTableView;
@property (strong, nonatomic) SWRevealViewController *viewController;
@property (strong,nonatomic) IBOutlet KASlideShow * slideshow;

@end


