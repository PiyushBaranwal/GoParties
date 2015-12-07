//
//  AboutViewController.h
//  GoParties
//
//  Created by GoParties on 05/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    IBOutlet UITableView *aboutTableView;
    
}

@property(nonatomic,retain)IBOutlet UITableView *aboutTableView;

@end

