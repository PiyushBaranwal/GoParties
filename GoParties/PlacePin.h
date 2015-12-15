//
//  PlacePin.h
//  LinkIn
//
//  Created by Piyush Baranwal on 19/09/14.
//  Copyright (c) 2014 BlueApple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PlacePin : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    int nTag;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic) int nTag;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end