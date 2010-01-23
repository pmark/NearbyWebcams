//
//  MainViewController.m
//  NearbyWebcams
//
//  Created by P. Mark Anderson on 1/22/10.
//  Copyright Bordertown Labs, LLC 2010. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"

#define WEBCAMS_API_KEY @"6edcac77158f8433f2767a4a1b37a01a"
#define WEBCAMS_API_UNITS @"km" // can be km or mi

@implementation MainViewController
@synthesize sm3dar, webcams;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    self.webcams = [[WebcamsTravelClient alloc] init];
    self.webcams.apiKey = WEBCAMS_API_KEY;
    self.webcams.resultsDelegate = self;
  }
  return self;
}

- (void)dealloc {
  [sm3dar release];
  [webcams release];
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.sm3dar = [[[SM3DAR_Controller alloc] init] autorelease];
  [self.view addSubview:sm3dar.view];
  sm3dar.delegate = self;
}

#pragma mark -

-(void)loadPointsOfInterest {
  self.sm3dar.markerViewClass = nil;
  
  CLLocation *loc = [self.sm3dar currentLocation];
  CGFloat radius = [SM3DAR_Session sharedSM3DAR_Session].farClipMeters / 1000.0f;
  
  [self.webcams fetch:loc.coordinate.latitude longitude:loc.coordinate.longitude radius:radius unit:WEBCAMS_API_UNITS];
}


-(void)didChangeFocusToPOI:(SM3DAR_PointOfInterest*)newPOI fromPOI:(SM3DAR_PointOfInterest*)oldPOI {
  
  // POI acquired focus
  
}


-(void)didChangeSelectionToPOI:(SM3DAR_PointOfInterest*)newPOI fromPOI:(SM3DAR_PointOfInterest*)oldPOI {
  
  // POI was selected
  
}

#pragma mark -

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
  
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo {    
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark -
- (void) apiClient:(APIClient*)client didReceiveErrorMessages:(NSArray*)messages {
}

- (void) apiClient:(APIClient*)client didReceiveEmptyResultSet:(NSDictionary*)parameters {
}

- (void) apiClient:(APIClient*)client didReceiveRemoteItems:(NSArray*)results {
}


@end
