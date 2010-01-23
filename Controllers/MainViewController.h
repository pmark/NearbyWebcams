//
//  MainViewController.h
//  NearbyWebcams
//
//  Created by P. Mark Anderson on 1/22/10.
//  Copyright Bordertown Labs, LLC 2010. All rights reserved.
//

#import "FlipsideViewController.h"
#import "SM3DAR.h"
#import "WebcamsTravelClient.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, SM3DAR_Delegate, APIClientDelegate> {
  SM3DAR_Controller *sm3dar;
  WebcamsTravelClient *webcams;
}

@property (nonatomic, retain) SM3DAR_Controller *sm3dar;
@property (nonatomic, retain) WebcamsTravelClient *webcams;

- (IBAction)showInfo;

@end
