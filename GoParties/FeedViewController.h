//
//  FeedViewController.h
//  GoParties
//
//  Created by GoParties on 05/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KASlideShow.h"


@interface FeedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,KASlideShowDelegate>
{
    IBOutlet UITableView *feedTableView;
    
}

@property (nonatomic,retain)IBOutlet UITableView *feedTableView;
@property (strong,nonatomic) IBOutlet KASlideShow * slideshow;


@end
