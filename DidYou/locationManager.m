//
//  locationManager.m
//  DidYou
//
//  Created by Zirui Branton on 4/1/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "locationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface locationManager()

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) CLPlacemark *placemark;

@end

@implementation locationManager

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.geocoder = [[CLGeocoder alloc]init];
        
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
    [self.locationManager startUpdatingLocation];
    
    }
    return self;

}


//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//    
//    NSLog(@"didFailWithError, %@", error);
//    
//    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to get where you are" preferredStyle:UIAlertControllerStyleAlert];
//    
//    
//    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    
//    [errorAlert addAction:defaultAction];
//    
//    [self presentViewController:errorAlert animated:YES completion:nil];
//    
//}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    
    CLLocation *currentLocation = locations[0];
    
    if (currentLocation != nil) {
        
        self.latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
        self.longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        
        //stop location manager
        
        [self.locationManager stopUpdatingLocation];
        
        NSLog(@"resolving the address");
        
        //translate the locate data into a human-readable address
        [self.geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            if (error == nil && [placemarks count] > 0) {
                self.placemark = [placemarks lastObject];
                self.addressLabel.text = [NSString stringWithFormat:@"%@ %@", self.placemark.locality, self.placemark.country];
                
            } else {
                
                NSLog(@"@%@", error.debugDescription);
            }
        }];
    }
    
    
}



@end
