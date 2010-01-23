//
//  NearbyWebcamsAppDelegate.h
//  NearbyWebcams
//
//  Created by P. Mark Anderson on 1/22/10.
//  Copyright Bordertown Labs, LLC 2010. All rights reserved.
//

@class MainViewController;

@interface NearbyWebcamsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainViewController *mainViewController;

@end

