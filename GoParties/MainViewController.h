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

@interface MainViewController : UIViewController<SWRevealViewControllerDelegate,KASlideShowDelegate,UITableViewDataSource,UITableViewDelegate>

{
    IBOutlet UITableView *listTableView;
    
    NSMutableArray *iconImgArray;
    NSMutableArray *titleArray;
    NSMutableArray *descArray;
}


@property (nonatomic,retain)IBOutlet UITableView *listTableView;
@property (strong, nonatomic) SWRevealViewController *viewController;
@property (strong,nonatomic) IBOutlet KASlideShow * slideshow;

@end


