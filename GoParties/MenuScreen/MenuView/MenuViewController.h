//
//  MenuViewController.h
//  LinkIn
//
//  Created by Piyush Baranwal on 23/09/14.
//  Copyright (c) 2014 BlueApple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideCustomCell.h"


@interface MenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet SlideCustomCell *cell;
    
    IBOutlet  UIImageView *logoImgView;
    IBOutlet UIImageView *indeImgView;
    IBOutlet UILabel *textLbl;
    
    IBOutlet UILabel *nameLbl;
    IBOutlet UILabel *cardLbl;
    
   IBOutlet UIImageView *userImgView;
    IBOutlet UIImageView *backImageView;
    IBOutlet UITableView *menuTableView;
    
    IBOutlet UIButton *iconBtn;
    
    NSString *ImgUrlStr;
    
    NSMutableArray *indexPathArray;
    
    BOOL logged;
    
}

@property (nonatomic,retain) UIImageView *selectedBackgroundView;

@property (nonatomic, retain) IBOutlet UITableView *menuTableView;

@property (nonatomic ,retain) NSString *tokenKey;
@property (nonatomic,retain) NSString *tokenSecretKey;

- (IBAction)iconBtnClick:(id)sender;




@end
