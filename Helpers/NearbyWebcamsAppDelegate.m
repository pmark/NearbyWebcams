//
//  NearbyWebcamsAppDelegate.m
//  NearbyWebcams
//
//  Created by P. Mark Anderson on 1/22/10.
//  Copyright Bordertown Labs, LLC 2010. All rights reserved.
//

#import "NearbyWebcamsAppDelegate.h"
#import "MainViewController.h"

@implementation NearbyWebcamsAppDelegate


@synthesize window;
@synthesize mainViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
	MainViewController *aController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	self.mainViewController = aController;
	[aController release];
	
    mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	[window addSubview:[mainViewController view]];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [mainViewController release];
    [window release];
    [super dealloc];
}

@end
