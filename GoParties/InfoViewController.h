//
//  InfoViewController.h
//  GoParties
//
//  Created by GoParties on 15/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *infoTableView;
    
}

@property (nonatomic,retain)IBOutlet UITableView *infoTableView;


@end
