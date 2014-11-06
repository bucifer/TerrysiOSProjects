//
//  MapViewController.m
//  Week 5 MapView Terry
//
//  Created by Aditya Narayan on 9/25/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "MapViewController.h"
#import "WebViewController.h"
#import "RestaurantPointAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager setDelegate:self];

    if (IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
//        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    //Place a single pin on TurnToTech
    MKPointAnnotation *TTTannotation = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D TTTCoordinate;
    TTTCoordinate.latitude = 40.741444;
    TTTCoordinate.longitude = -73.990070;
    [TTTannotation setCoordinate:TTTCoordinate];
    [TTTannotation setTitle:@"TurnToTech"];
    TTTannotation.subtitle = @"Subtitle: TurnToTech Office is here!!!!";
    [self.myMapView addAnnotation:TTTannotation];
    [self.myMapView selectAnnotation:TTTannotation animated:YES];
    
    self.myMapView.delegate = self;
    self.myMapView.showsUserLocation = YES;
    [self.myMapView setMapType:MKMapTypeStandard];
    [self.myMapView setZoomEnabled:YES];
    [self.myMapView setScrollEnabled:YES];
    
    

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    WebViewController *webVC = [segue destinationViewController];
    webVC.url = self.url;
}


- (void)requestDataFromAPI:(MKUserLocation *)userLocation {
    //initialize your responseData here
    self.responseData = [NSMutableData data];
    
    NSString *myAPIKey = @"AIzaSyCdMoZiea0Z96EhH8cc3No7KJHv2rjey_c";
    
    NSString *requestString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=1000&types=restaurant&opennow=1&key=%@", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude, myAPIKey];
    
    NSURL *APIRequestURL = [NSURL URLWithString:requestString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:APIRequestURL];
    request.HTTPMethod = @"GET";
    //Fire the request you made before
    NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest: request delegate: self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentMapSelection:(id)sender {
    
    switch (((UISegmentedControl*)sender).selectedSegmentIndex) {
        case 0:
            self.myMapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.myMapView.mapType = MKMapTypeHybrid;
            break;
        case 2:
            self.myMapView.mapType = MKMapTypeSatellite;
            break;
    }
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    NSLog(@"Location: %f, %f",
          userLocation.location.coordinate.latitude,
          userLocation.location.coordinate.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 2000, 2000);
    
    //you can set zoom to 50000 on each to make it nicely zoomed out
    [self.myMapView setRegion:region animated:YES];
    
//    Place a single pin at where you are
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
    [annotation setCoordinate:userLocation.coordinate];
    [annotation setTitle:@"You are here"];
    annotation.subtitle = @"GPS says that you are here";
    [self.myMapView addAnnotation:annotation];
    [self.myMapView selectAnnotation:annotation animated:YES];
    
    [self requestDataFromAPI:userLocation];
}

#pragma mark NSURLConnection Delegate Methods

- (void) connection:(NSURLConnection* )connection didReceiveResponse:(NSURLResponse *)response {
    //this handler, gets hit ONCE

}

- (void)connection: (NSURLConnection *)connection didReceiveData:(NSData *) data {
    //this handler, gets hit SEVERAL TIMES
    //Append new data to the instance variable everytime new data comes in
    
    [self.responseData appendData:data];

}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    //Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //this handler gets hit ONCE
    // The request is complete and data has been received
    // You can parse the stuff in your data variable now or do whatever you want

    NSLog(@"connection finished");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    //Convert your responseData object
    NSError *myError = nil;
    NSDictionary *responseDataInNSDictionary = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    NSArray *resultsArray = [responseDataInNSDictionary objectForKey:@"results"];
    for (int i=0; i < resultsArray.count; i++) {
        NSDictionary *restaurantObject = resultsArray[i];
        NSString *restaurantName = [restaurantObject objectForKey:@"name"];
        NSLog(@"%@", restaurantName);
        NSDictionary *geometryObject = [restaurantObject objectForKey:@"geometry"];
        NSDictionary *locationObject = [geometryObject objectForKey:@"location"];
        NSLog(@"%@ %@", [locationObject objectForKey:@"lat"], [locationObject objectForKey:@"lng"]);
        
        //Place the pin on these restaurants
        RestaurantPointAnnotation *annotation = [[RestaurantPointAnnotation alloc]init];
        
        CLLocationCoordinate2D restaurantCoordinate = CLLocationCoordinate2DMake([[locationObject objectForKey:@"lat"] doubleValue], [[locationObject objectForKey:@"lng"] doubleValue]);
        
        [annotation setCoordinate:restaurantCoordinate];
        [annotation setTitle:restaurantName];
        
        annotation.subtitle = [restaurantObject objectForKey:@"icon"];
        self.url = annotation.subtitle;
        
        [self.myMapView addAnnotation:annotation];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    else if ([annotation isKindOfClass:[RestaurantPointAnnotation class]]) {
        MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
        annotationView.canShowCallout = YES;
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return annotationView;
    }
    else {
        MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
        annotationView.canShowCallout = YES;
        return annotationView;
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    // Perform Segue
    [self performSegueWithIdentifier:@"webViewSegue" sender:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}


@end
