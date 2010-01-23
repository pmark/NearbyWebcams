//
//  MainViewController.m
//  NearbyWebcams
//
//  Created by P. Mark Anderson on 1/22/10.
//  Copyright Bordertown Labs, LLC 2010. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"


@implementation MainViewController
@synthesize sm3dar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    // Custom initialization
  }
  return self;
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


- (void)dealloc {
  [sm3dar release];
  [super dealloc];
}


@end
