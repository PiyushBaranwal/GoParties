//
//  LocationViewController.h
//  GoParties
//
//  Created by GoParties on 15/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PlacePin.h"

@interface LocationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate>
{
    IBOutlet UITableView *locationTableView;
    
    IBOutlet MKMapView *myMapView;
    PlacePin *mapPoint;
    
    
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    CLLocationCoordinate2D location;

    
}

@property (nonatomic,retain)IBOutlet UITableView *locationTableView;
@property(nonatomic,retain) IBOutlet MKMapView *myMapView;



-(void)zoomToFitMapAnnotations:(MKMapView*)mv;



@end
