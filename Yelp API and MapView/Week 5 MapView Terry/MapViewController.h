//
//  MapViewController.h
//  Week 5 MapView Terry
//
//  Created by Aditya Narayan on 9/25/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WebViewController.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue])

@interface MapViewController : UIViewController
<CLLocationManagerDelegate, MKMapViewDelegate, NSURLConnectionDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@property (strong, nonatomic) IBOutlet MKMapView *myMapView;
@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) NSString* url;
@property (strong, nonatomic) CLLocationManager *locationManager;

- (IBAction)segmentMapSelection:(id)sender;


//class methods

- (void) requestDataFromAPI:(MKUserLocation *)userLocation;


@end
