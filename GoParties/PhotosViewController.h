//
//  PhotosViewController.h
//  GoParties
//
//  Created by GoParties on 14/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iCarousel.h"

#import "SWRevealViewController.h"

@interface PhotosViewController : UIViewController<iCarouselDataSource,iCarouselDelegate,SWRevealViewControllerDelegate,NSURLConnectionDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *photoTableView;
   // IBOutlet UICollectionView *collectionViewPack;
    
    
    IBOutlet UIButton *homeBtn;
    IBOutlet UIButton *myProfBtn;
    IBOutlet UIButton *myPartiesbtn;
    IBOutlet UIButton *myDealsBtn;
    
    IBOutlet UIButton *accessBtn;
    
    NSArray *recipeImages;
    UIView *locView;
    UIImageView *galImageView;
    UIButton *cancelBtn;
    
    IBOutlet UIImageView *clickedImgView;
    
    NSMutableArray *galleryImages;
    
    NSMutableArray *thumbImgArray;
    NSMutableArray *oriImgArray;
    
    int  selectedImgInd;
    
    //For webservices
    NSMutableData *responseData;
    NSURLConnection *conn;
    NSMutableData *webData;
    NSString *responseString;
}

@property (nonatomic,retain) IBOutlet UITableView *photoTableView;

//@property(nonatomic,retain)IBOutlet UICollectionView *collectionViewPack;
@property (nonatomic,retain)IBOutlet UIImageView *imgView;


@property (nonatomic, strong) IBOutlet iCarousel *carousel;


- (IBAction)homeBtnClick:(id)sender;
- (IBAction)myProfileBtnClick:(id)sender;
- (IBAction)myPartiesBtnClick:(id)sender;
- (IBAction)myDealsBtnClick:(id)sender;
- (IBAction)accessBtnClick:(id)sender;


@end
