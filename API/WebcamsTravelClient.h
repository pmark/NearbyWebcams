//
//  ListingClient.h
//
//  Created by P. Mark Anderson on 12/7/09.
//  Copyright 2009 Bordertown Labs, LLC. All rights reserved.
//

#import "APIClient.h"
#import <MapKit/MapKit.h>

@interface WebcamsTravelClient : APIClient {
}

- (void) fetch:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude radius:(CGFloat)radius unit:(NSString*)unit;

@end
