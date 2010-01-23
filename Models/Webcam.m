//
//  Webcam.m
//  NearbyWebcams
//
//  Created by P. Mark Anderson on 1/22/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import "Webcam.h"


@implementation Webcam

- (SM3DAR_PointOfInterest*) pointOfInterest {
  SM3DAR_PointOfInterest *poi;
	CLLocation *tempLocation;
	CLLocationCoordinate2D location;
  double lat, lng, alt;

  NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
  lat = [[formatter numberFromString:[self getString:@"latitude"]] doubleValue];
  lng = [[formatter numberFromString:[self getString:@"longitude"]] doubleValue];
  alt = 0.0;
  [formatter release];
  location.latitude = lat;
  location.longitude = lng;
  tempLocation = [[CLLocation alloc] initWithCoordinate:location altitude:alt horizontalAccuracy:1.0 verticalAccuracy:1.0 timestamp:[NSDate date]];
  
  NSString *title = [self getString:@"title"];
  NSString *subtitle = [self getString:@"user"];
  NSURL *url = [NSURL URLWithString:[self getString:@"url"]];
  
  poi = [[SM3DAR_PointOfInterest alloc] initWithLocation:tempLocation title:title subtitle:subtitle url:url];
  
  [tempLocation release];		
  
  return poi;
}

@end
