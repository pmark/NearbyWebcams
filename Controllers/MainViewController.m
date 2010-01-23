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
  self.sm3dar.markerViewClass = [WebcamMarkerView class];
  
  CLLocation *loc = [self.sm3dar currentLocation];
  CGFloat radius = [SM3DAR_Session sharedSM3DAR_Session].farClipMeters / 1000.0f;
  
  [self.webcams fetch:loc.coordinate.latitude longitude:loc.coordinate.longitude radius:radius unit:WEBCAMS_API_UNITS];
}

#pragma mark Webcam API
- (void) apiClient:(APIClient*)client didReceiveErrorMessages:(NSArray*)messages {
}

- (void) apiClient:(APIClient*)client didReceiveEmptyResultSet:(NSDictionary*)parameters {
}

- (void) apiClient:(APIClient*)client didReceiveRemoteItems:(NSArray*)results {
  //NSLog(@"[MVC] webcams: %@", results);  
  NSMutableArray *points = [NSMutableArray arrayWithCapacity:[results count]];

  for (NSDictionary *attribs in results) {
    Webcam *webcam = [[Webcam alloc] initWithDictionary:attribs];
    SM3DAR_PointOfInterest *poi = [self.sm3dar initPointOfInterest:[webcam pointOfInterestData]];
    [points addObject:poi];
    [poi release];
    [webcam release];
  }

  [self.sm3dar addPointsOfInterest:points];
  [self.sm3dar zoomMapToFit];
}

#pragma mark -


-(void)didChangeFocusToPOI:(SM3DAR_PointOfInterest*)newPOI fromPOI:(SM3DAR_PointOfInterest*)oldPOI {
  CGFloat maxScale = 2.5f;
  
  WebcamMarkerView *oldView = (WebcamMarkerView*)oldPOI.view;
  [self addResizeAnimation:oldView scalar:1.0];

  WebcamMarkerView *newView = (WebcamMarkerView*)newPOI.view;
  [self addResizeAnimation:newView scalar:maxScale];  
}

- (void) addResizeAnimation:(WebcamMarkerView*)markerView scalar:(CGFloat)scalar {
//  NSLog(@"Scaling by %f", scalar);
	CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];	
  [anim setToValue:[NSNumber numberWithFloat:scalar]];
  anim.fillMode = kCAFillModeForwards;
  anim.removedOnCompletion = NO;
  anim.autoreverses = NO;
  anim.duration = 1.0;

	[markerView.layer addAnimation:anim forKey:@"resize"];

  markerView.distanceScaleFactor = 2.5;
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
