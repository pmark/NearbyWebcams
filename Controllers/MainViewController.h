//
//  MainViewController.h
//  NearbyWebcams
//
//  Created by P. Mark Anderson on 1/22/10.
//  Copyright Bordertown Labs, LLC 2010. All rights reserved.
//

#import "FlipsideViewController.h"
#import "SM3DAR.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, SM3DAR_Delegate> {
  SM3DAR_Controller *sm3dar;
}

@property (nonatomic, retain) SM3DAR_Controller *sm3dar;

- (IBAction)showInfo;

@end
