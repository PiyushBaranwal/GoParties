//
//  MyFeedViewController.h
//  GoParties
//
//  Created by GoParties on 04/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFeedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *feedTableView;
    
}

@property (nonatomic,retain)IBOutlet UITableView *feedTableView;


@end
