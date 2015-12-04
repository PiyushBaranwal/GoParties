//
//  MyPartiesViewController.h
//  GoParties
//
//  Created by GoParties on 04/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPartiesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *myPartiesTableView;
    
    UIImageView *bannerImg;
     UIScrollView *scrollView;
}


@property (nonatomic,retain) UIScrollView *scrollView;

@property (nonatomic,retain)IBOutlet UITableView *myPartiesTableView;
@end
