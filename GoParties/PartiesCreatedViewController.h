//
//  PartiesCreatedViewController.h
//  GoParties
//
//  Created by GoParties on 05/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartiesCreatedViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *partiesTableView;
    
    UIImageView *bannerImg;
    UIScrollView *scrollView;
}


@property (nonatomic,retain) UIScrollView *scrollView;

@property (nonatomic,retain)IBOutlet UITableView *partiesTableView;
@end
