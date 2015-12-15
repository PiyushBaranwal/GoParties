//
//  WebViewController.h
//  GoParties
//
//  Created by GoParties on 11/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
{
    UIImageView *imgView;
    UIButton *refreshBtn ;
    NSString *urlStr;
    NSString *userEmail;
    NSString *userPassword;
    
    
    NSString *enteredUserName;
    NSString *enteredUserPassword;
    NSString *fbId;
    NSString *gpId;
}


@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,retain) NSString *urlStr;
@property (nonatomic,retain)NSString *enteredUserName;
@property (nonatomic,retain)NSString *enteredUserPassword;
@property(nonatomic,retain) NSString *fbId;
@property (nonatomic,retain)NSString *gpId;

@end
