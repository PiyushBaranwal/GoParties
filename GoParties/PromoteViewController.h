//
//  PromoteViewController.h
//  GoParties
//
//  Created by GoParties on 04/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromoteViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>

{
    IBOutlet UITableView *promoteTableView;
    UITextView *detailTextView;
    UITextView *detailTextView1;
    UITextField *phoneTextField;
    UIButton *callBackBtn;
}

@property(nonatomic,retain)IBOutlet UITableView *promoteTableView;

@end
