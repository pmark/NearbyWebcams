/*
 *  SM3DAR.h
 *
 *  Copyright 2009 Spot Metrix, Inc. All rights reserved.
 *
 *  API for 3DAR.
 *
 */

#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>


@class SM3DAR_PointOfInterest;		
@class SM3DAR_Session;
@class SM3DAR_FocusView;

@protocol SM3DAR_Delegate
-(void)sm3darViewDidLoad;
-(void)loadPointsOfInterest;
-(void)didChangeFocusToPOI:(SM3DAR_PointOfInterest*)newPOI fromPOI:(SM3DAR_PointOfInterest*)oldPOI;
-(void)didChangeSelectionToPOI:(SM3DAR_PointOfInterest*)newPOI fromPOI:(SM3DAR_PointOfInterest*)oldPOI;
@end

@interface SM3DAR_Controller : UIViewController <UIAccelerometerDelegate, CLLocationManagerDelegate, MKMapViewDelegate> {
	BOOL originInitialized;
	MKMapView *map;	
	UILabel *statusLabel;
	UIImagePickerController *camera;
	NSObject<SM3DAR_Delegate> *delegate;
	NSMutableArray *pointsOfInterest;
	SM3DAR_PointOfInterest *focusedPOI;
	SM3DAR_PointOfInterest *selectedPOI;
	Class markerViewClass;
}

@property (assign) BOOL originInitialized;
@property (nonatomic, retain) MKMapView *map;
@property (nonatomic, retain) UILabel *statusLabel;
@property (nonatomic, retain) UIImagePickerController *camera;
@property (nonatomic, assign) NSObject<SM3DAR_Delegate> *delegate;
@property (nonatomic, retain) NSMutableDictionary *pointsOfInterest;
@property (nonatomic, retain) SM3DAR_PointOfInterest *focusedPOI;
@property (nonatomic, retain) SM3DAR_PointOfInterest *selectedPOI;
@property (nonatomic, assign) Class markerViewClass;
@property (nonatomic, retain) SM3DAR_FocusView *focusView;

// points of interest
- (void)addPointOfInterest:(SM3DAR_PointOfInterest*)point;
- (void)addPointsOfInterest:(NSArray*)points;
- (void)removePointOfInterest:(SM3DAR_PointOfInterest*)point;
- (void)removePointsOfInterest:(NSArray*)points;
- (void)removeAllPointsOfInterest;
- (void)replaceAllPointsOfInterestWith:(NSArray*)points;
- (NSString*)loadJSONFromFile:(NSString*)fileName;
- (void)loadMarkersFromJSONFile:(NSString*)jsonFileName;
- (void)loadMarkersFromJSON:(NSString*)sm3dar_jsonString;
- (SM3DAR_PointOfInterest*)initPointOfInterest:(NSDictionary*)properties;

- (UIView *)viewForCoordinate:(SM3DAR_PointOfInterest*)poi;
- (BOOL)displayPoint:(SM3DAR_PointOfInterest*)poi;
- (CLLocation*)currentLocation;
- (void)startCamera;
- (void)stopCamera;
- (void)suspend;
- (void)resume;
- (CATransform3D)cameraTransform;
- (void)debug:(NSString*)message;
- (CGRect)logoFrame;
- (void)addFocusView:(SM3DAR_FocusView*)customFocusView;

// map
- (void)initMap;
- (void)toggleMap;
- (void)showMap;
- (void)hideMap;
- (void)zoomMapToFit;
- (void)setCurrentMapLocation:(CLLocation *)location;
- (void)fadeMapToAlpha:(CGFloat)alpha;
- (BOOL)mapIsVisible;
- (BOOL)setMapVisibility;
- (void)annotateMap;
- (void)centerMapOnCurrentLocation;
@end


@class SM3DAR_Controller;
@interface SM3DAR_PointOfInterest : CLLocation <MKAnnotation> {
	NSString *title;
	NSString *subtitle;
	NSURL *dataURL;
	BOOL hasFocus;
	NSObject<SM3DAR_Delegate> *delegate;
	UIView *view;
	SM3DAR_Controller *controller;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, retain) NSURL *dataURL;
@property (nonatomic, assign) NSObject<SM3DAR_Delegate> *delegate;
@property (nonatomic, retain) UIView *view;
@property (nonatomic, retain) SM3DAR_Controller *controller;
@property (assign) BOOL hasFocus;
@property (nonatomic, retain) NSDictionary *properties;

- (UIView*)defaultView;
- (id)initWithLocation:(CLLocation*)loc properties:(NSDictionary*)props;
- (id)initWithLocation:(CLLocation*)loc title:(NSString*)title subtitle:(NSString*)subtitle url:(NSURL*)url;
- (CGFloat)distanceInMetersFrom:(CLLocation*)otherPoint;
- (CGFloat)distanceInMetersFromCurrentLocation;
- (NSString*)formattedDistanceInMetersFrom:(CLLocation*)otherPoint;
- (NSString*)formattedDistanceInMetersFromCurrentLocation;
- (CGFloat)distanceInMilesFrom:(CLLocation*)otherPoint;
- (CGFloat)distanceInMilesFromCurrentLocation;
- (NSString*)formattedDistanceInMilesFrom:(CLLocation*)otherPoint;
- (NSString*)formattedDistanceInMilesFromCurrentLocation;
- (BOOL)isInView:(CGPoint*)point;
- (CATransform3D)objectTransform;
@end

@interface SM3DAR_Session : NSObject {
	CLLocation *currentLocation;
	CGFloat nearClipMeters;
	CGFloat farClipMeters;
}

@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, assign) CGFloat nearClipMeters;
@property (nonatomic, assign) CGFloat farClipMeters;

+ (SM3DAR_Session*)sharedSM3DAR_Session;
@end


@interface SM3DAR_MarkerView : UIView {
	SM3DAR_PointOfInterest *poi;
	CGFloat distanceScaleFactor;
}
@property (nonatomic, retain) SM3DAR_PointOfInterest *poi;
@property (assign) CGFloat distanceScaleFactor;
- (id)initWithPointOfInterest:(SM3DAR_PointOfInterest*)pointOfInterest;
- (void)buildView;
- (void)scaleToRange;
- (void)didReceiveFocus;
@end


@interface SM3DAR_IconMarkerView : SM3DAR_MarkerView {
	UIImageView *icon;
}
@property (nonatomic, retain) UIImageView *icon;
+ (NSString*)randomIconName;
@end


@interface SM3DAR_FocusView : UIView {
	SM3DAR_PointOfInterest *poi;
}
@property (nonatomic, retain) SM3DAR_PointOfInterest *poi;
- (void)buildView;
- (void)didChangeFocusToPOI:(SM3DAR_PointOfInterest*)newPOI;
- (void)updatePositionAndOrientation:(CGFloat)screenOrientationRadians;
@end
