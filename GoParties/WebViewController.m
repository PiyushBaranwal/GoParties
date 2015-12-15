//
//  WebViewController.m
//  GoParties
//
//  Created by GoParties on 11/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "WebViewController.h"

#import "Singleton.h"
#import "Utils.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize webView,urlStr,enteredUserPassword,enteredUserName,fbId,gpId;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //to hide the back button on navigation bar
 // [self.navigationItem setHidesBackButton:YES animated:YES];
//    // to hide the navigation abr
//     self.navigationController.navigationBarHidden = YES;
    
  

    gpId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userGoogleId"];
    fbId=[[NSUserDefaults standardUserDefaults]objectForKey:@"userFacebookId"];

    
    
    
    
    //to get the usermail and user password from local database
    userEmail=[[NSUserDefaults standardUserDefaults] objectForKey:@"userEmail"];
    userPassword=[[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"];
    NSLog(@"userEmail=%@",userEmail);
    NSLog(@"userPassword=%@",userPassword);
    
    [Utils startActivityIndicatorInView:self.view withMessage:@"Loading..."];
    
        BOOL checkConn=[Singleton checkinternetconnection];
        if(checkConn)
        {//Do any additional setup after loading the view, typically from a nib.
            //@"%@/email=%@&passord=%@&access_token=%@";
            NSString *urlAsString;
            if (enteredUserName)
            {
                 urlAsString=[NSString stringWithFormat:@"%@?email=%@&password=%@&access_token=%@",urlStr,enteredUserName,enteredUserPassword,@"133688745fb3253a0b4c3cbb3f67d444cf4b418a"];
            }
            else if (fbId)
            {
              urlAsString=[NSString stringWithFormat:@"%@?facebook_id=%@&access_token=%@",urlStr,fbId,@"133688745fb3253a0b4c3cbb3f67d444cf4b418a"];
                NSLog(@"urlStr=%@",urlStr);
            }
            else if (gpId)
            {
               urlAsString=[NSString stringWithFormat:@"%@?google_id=%@&access_token=%@",urlStr,gpId,@"133688745fb3253a0b4c3cbb3f67d444cf4b418a"];
            }
           else
           {
              // NSLog(@"Error");
               // for continue as guest
               urlAsString=urlStr;
           }
            
           // NSString *urlString = @"http://dev.goparties.com/m-new";
            NSURL *url = [NSURL URLWithString:urlAsString];
            NSLog(@"Web url=%@",url);
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
            [self.webView loadRequest:urlRequest];
    
            [Utils stopActivityIndicatorInView:self.view];
        }
        else
        {
    
    //For First image
    imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 320, 548)];
    imgView.backgroundColor=[UIColor lightGrayColor];
   // imgView.image=[UIImage imageNamed:@"iphone5.png"];
    
    
    
    // for refreshButtn
    refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshBtn addTarget:self
                   action:@selector(refreshBtnClick)
         forControlEvents:UIControlEventTouchUpInside];
    [refreshBtn setTitle:@"" forState:UIControlStateNormal];
    refreshBtn.frame = CGRectMake(130.0, 270.0, 60.0, 60.0);
    [refreshBtn setBackgroundColor:[UIColor greenColor]];
    [self.webView addSubview:refreshBtn];
    [self.webView addSubview:imgView];
    
    //To show error no internet connection
    // [Singleton connectionErrorMsg];
    
    [Utils stopActivityIndicatorInView:self.view];
    }
    
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)refreshBtnClick
{
    
    NSLog(@"refresh Btn Clicked");
//    NSString *urlString = @"http://dev.goparties.com/m-new";
//    NSURL *url = [NSURL URLWithString:urlString];
    
    NSString *urlAsString;
    urlAsString=[NSString stringWithFormat:@"%@/email=%@&passord=%@&access_token=%@",urlStr,userEmail,userPassword,@"133688745fb3253a0b4c3cbb3f67d444cf4b418a"];
    // NSString *urlString = @"http://dev.goparties.com/m-new";
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    
    [imgView removeFromSuperview];
    [refreshBtn removeFromSuperview];
    
    //[Utils stopActivityIndicatorInView:self.view];
}

#pragma mark- deleagte methods of webview
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //For marriot
    //    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('field-user-id').value = '135892950'"];
    //  [self.webView stringByEvaluatingJavaScriptFromString:@"document.signInForm.j_username.value = 'rewardsWebService@135892950'"];
    //  [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('field-password').value = 'Gurpreet123'"];
    
   // [Utils stopActivityIndicatorInView:self.view];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"Loading URL :%@",request.URL.absoluteString);
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // do code, when web view detect error during load failure.
    //For First image
    UIImageView *imgView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 320, 548)];
    imgView1.backgroundColor=[UIColor lightGrayColor];
    //imgView1.image=[UIImage imageNamed:@"NICiphone5.png"];
    [self.webView addSubview:imgView1];
}


/* for run this delete above viewDidload method remove this comment.
 // ******** Create UIWebView Programmatically ********
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 Do any additional setup after loading the view, typically from a nib.
 UIWebView *webView = [[UIWebView alloc]init];
 NSString *urlString = @"http://dev.goparties.com/m";
 NSURL *url = [NSURL URLWithString:urlString];
 NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
 [webView loadRequest:urlRequest];
 [self.view addSubview:webView];
 
 }
 */



@end
