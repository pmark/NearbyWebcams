//
//  WebcamMarkerView.m
//
//  Created by P. Mark Anderson on 1/22/2010.
//

#import "WebcamMarkerView.h"

#define DEFAULT_MARKER_SIZE 20

@implementation WebcamMarkerView
@synthesize artworkFetcher;

- (void) buildView {
  NSLog(@"building WebcamMarkerView");

  UIImage *img = [UIImage imageNamed:@"bubble1.png"];
	self.icon = [[[UIImageView alloc] initWithImage:img] autorelease];
  self.frame = CGRectMake(0, 0, DEFAULT_MARKER_SIZE, DEFAULT_MARKER_SIZE);	
	[self addSubview:icon];
  
  // URL format is http://images.webcams.travel/webcam/1240209999.jpg
  NSString *photoURL = [self.poi.properties objectForKey:@"thumbnail_url"];
  if ([photoURL length] > 0) {
    photoURL = [photoURL stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"webcam"];
    NSLog(@"[WMV] photoURL: %@", photoURL);

    self.artworkFetcher = [[[AsyncArtworkFetcher alloc] init] autorelease];
    artworkFetcher.url = [NSURL URLWithString:photoURL];
    artworkFetcher.delegate = self;
    [artworkFetcher fetch];
  }
}

- (void)artworkFetcher:(AsyncArtworkFetcher *)fetcher didFinish:(UIImage *)artworkImage {  
  //[self updateImage:[artworkImage retain]];
  [self updateImage:artworkImage];
}

- (void) updateImage:(UIImage*)img {
  NSLog(@"[WMV] updating webcam image %f, %f", img.size.width, img.size.height);
	self.icon.image = img;
	self.frame = CGRectMake(0, 0, img.size.width, img.size.height);	
}

- (void) didReceiveFocus {
	CGFloat poiScale = 3.0;
	self.transform = CGAffineTransformScale(self.transform, poiScale, poiScale);
}

- (void) dealloc {
  [artworkFetcher release];
  [super dealloc];
}

@end
