//
//  WebcamMarkerView.h
//
//  Created by P. Mark Anderson on 1/22/2010.
//

#import "SM3DAR.h"
#import "AsyncArtworkFetcher.h"

@interface WebcamMarkerView : SM3DAR_IconMarkerView {
  AsyncArtworkFetcher *artworkFetcher;
}

@property (nonatomic,retain) AsyncArtworkFetcher *artworkFetcher;

- (void) updateImage:(UIImage*)newImage;

@end
