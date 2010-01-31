//
//  MainViewController.m
//  NearbyWebcams
//
//  Created by P. Mark Anderson on 1/22/10.
//  Copyright Bordertown Labs, LLC 2010. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "Webcam.h"
#import "PlacardFocusView.h"

#define WEBCAMS_API_KEY @"6edcac77158f8433f2767a4a1b37a01a"
#define WEBCAMS_API_UNITS @"km" // can be km or mi
#define TAG_FOCUS_VIEW 3243

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
  sm3dar.delegate = self;
  [self.view addSubview:sm3dar.view];

  [self.sm3dar.focusView removeFromSuperview];
  [self.sm3dar addFocusView:[[[PlacardFocusView alloc] initWithFrame:self.view.frame] autorelease]];
  self.sm3dar.focusView.tag = TAG_FOCUS_VIEW;
}

#pragma mark -

-(void)loadPointsOfInterest {
  self.sm3dar.markerViewClass = [WebcamMarkerView class];
  
  CLLocation *loc = [self.sm3dar currentLocation];
  CGFloat radius = [SM3DAR_Controller sharedSM3DAR_Controller].farClipMeters / 1000.0f;
  
  [self.webcams fetch:loc.coordinate.latitude longitude:loc.coordinate.longitude radius:radius unit:WEBCAMS_API_UNITS];
  
  
}

#pragma mark Webcam API
- (void) apiClient:(APIClient*)client didReceiveErrorMessages:(NSArray*)messages {
}

- (void) apiClient:(APIClient*)client didReceiveEmptyResultSet:(NSDictionary*)parameters {
}

- (void) apiClient:(APIClient*)client didReceiveRemoteItems:(NSArray*)results {
  NSLog(@"[MVC] adding %i webcams", [results count]);    
  [self.sm3dar addPointsOfInterest:results];
  [self.sm3dar zoomMapToFit];
}

#pragma mark -


//-(void)didChangeFocusToPOI:(SM3DAR_PointOfInterest*)newPOI fromPOI:(SM3DAR_PointOfInterest*)oldPOI {
-(void)didChangeFocusToPOI:(SM3DAR_Point*)newPOI fromPOI:(SM3DAR_Point*)oldPOI {
  WebcamMarkerView *newView = (WebcamMarkerView*)newPOI.view;  
  //NSLog(@"[MVC] Changed focus to %@", newView.poi.title);

//  CGFloat maxScale = 2.3f;  
//  WebcamMarkerView *oldView = (WebcamMarkerView*)oldPOI.view;
//  [self addResizeAnimation:oldView scalar:(1.0 / maxScale)];
  //oldView.distanceScaleFactor = (1.0 / maxScale);

//  [self addResizeAnimation:newView scalar:maxScale];  
  
  [self.view bringSubviewToFront:newView];
  [self.view bringSubviewToFront:[self.view viewWithTag:TAG_FOCUS_VIEW]];
}

- (void) addResizeAnimation:(WebcamMarkerView*)markerView scalar:(CGFloat)scalar {
//  NSLog(@"Scaling by %f", scalar);
	CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];	
//  [anim setToValue:[NSNumber numberWithFloat:scalar]];
  [anim setToValue:[NSNumber numberWithFloat:scalar]];
  anim.fillMode = kCAFillModeForwards;
  anim.removedOnCompletion = YES;
  anim.autoreverses = NO;
  anim.duration = 0.4f;

//	[markerView.layer addAnimation:anim forKey:@"resize"];

//markerView.distanceScaleFactor = scalar;
//	markerView.layer.transform = CATransform3DMakeScale(scalar, scalar, 1.0);
//	markerView.layer.transform = CATransform3DScale(markerView.layer.transform, scalar, scalar, 1.0);
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

-(void)sm3darViewDidLoad {
}

@end
