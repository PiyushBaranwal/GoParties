//
//  HomeViewController.h
//  GoParties
//
//  Created by GoParties on 16/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "KASlideShow.h"

@interface HomeViewController : UIViewController<SWRevealViewControllerDelegate,KASlideShowDelegate>
{
    IBOutlet UIButton *loginBtn;
    IBOutlet UIButton *signUpBtn;
    
}

@property(nonatomic,retain) IBOutlet UIButton *loginBtn;
@property(nonatomic,retain)IBOutlet UIButton *signUpBtn;


@property (strong, nonatomic) SWRevealViewController *viewController;
@property (strong,nonatomic) IBOutlet KASlideShow * slideshow;

- (IBAction)loginBtnClick:(id)sender;
- (IBAction)signUpBtnClick:(id)sender;
- (IBAction)fbBtnClick:(id)sender;
- (IBAction)gpBtnClick:(id)sender;
- (IBAction)continueAsGuestBtnClick:(id)sender;


@end
