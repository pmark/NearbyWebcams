//
//  PlacardFocusView.m
//
//  Created by P. Mark Anderson on 12/3/09.
//  Copyright 2010 Spot Metrix. All rights reserved.
//

#import "PlacardFocusView.h"
#define DEFAULT_LABEL_TAG 10333

@implementation PlacardFocusView

- (void)buildView {
  NSLog(@"[pfv] buildView");
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 100)];
	label.backgroundColor = [UIColor blackColor];
	label.textColor = [UIColor whiteColor];
	label.shadowColor = [UIColor darkGrayColor];
	label.shadowOffset = CGSizeMake(1.2, 1.2);
	label.numberOfLines = 3;
	label.alpha = 1.0;
  label.adjustsFontSizeToFitWidth = YES;
	label.font = [UIFont systemFontOfSize:22];
	label.textAlignment = UITextAlignmentCenter;
	label.hidden = YES;
	label.tag = DEFAULT_LABEL_TAG;
  
//  CALayer *l = label.layer;
//  [l setMasksToBounds:YES];
//  [l setCornerRadius:4.0];
//  [l setBorderWidth:1.0];
//  [l setBorderColor:[[UIColor grayColor] CGColor]];
  
	[self addSubview:label];
}

- (void)didChangeFocusToPOI:(SM3DAR_PointOfInterest*)newPOI {
//	self.poi = newPOI;
	
	UILabel *label = (UILabel*)[self viewWithTag:DEFAULT_LABEL_TAG];
	if (label) {
		label.text = [NSString stringWithFormat:@"%@\n%@\n%@mi", newPOI.title, 
                  [newPOI.properties objectForKey:@"user"],
                  [newPOI formattedDistanceInMilesFromCurrentLocation]];
		[label sizeToFit];
	}
	
	self.hidden = NO;
}

- (void)updatePositionAndOrientation:(CGFloat)screenOrientationRadians {
	UILabel *label = (UILabel*)[self viewWithTag:DEFAULT_LABEL_TAG];
	if (label) {
//		CGFloat xpos = self.poi.view.center.x;
//		CGFloat ypos = self.poi.view.center.y;					
//		label.center = CGPointMake(xpos, ypos);		

//		label.transform = CGAffineTransformRotate(CGAffineTransformIdentity, screenOrientationRadians) ;
		label.hidden = NO;
	}
}

- (void)dealloc {
	[super dealloc];
}

@end
