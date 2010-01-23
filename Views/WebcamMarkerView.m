//
//  WebcamMarkerView.m
//
//  Created by P. Mark Anderson on 1/22/2010.
//

#import "WebcamMarkerView.h"

@implementation WebcamMarkerView
@synthesize artworkFetcher;

- (void) buildView {
  NSLog(@"building WebcamMarkerView");
  UIImage *img = [UIImage imageNamed:@"bubble1.png"];
	self.icon = [[[UIImageView alloc] initWithImage:img] autorelease];
	self.frame = CGRectMake(0, 0, img.size.width, img.size.height);	
	[self scaleToRange];
	[self addSubview:icon];

  self.artworkFetcher = [[[AsyncArtworkFetcher alloc] init] autorelease];
  artworkFetcher.url = [NSURL URLWithString:[self.poi.properties objectForKey:@"thumbnail_url"]];
  artworkFetcher.delegate = self;
  [artworkFetcher fetch];
}

- (void)artworkFetcher:(AsyncArtworkFetcher *)fetcher didFinish:(UIImage *)artworkImage {  
  //[self updateImage:[artworkImage retain]];
  [self updateImage:artworkImage];
}

- (void) updateImage:(UIImage*)img {
  NSLog(@"TV: updating image %f, %f", img.size.width, img.size.height);
	self.icon.image = img;
	self.frame = CGRectMake(0, 0, img.size.width, img.size.height);	
//	[self scaleToRange];
//	[self addSubview:icon];
//  [self setNeedsDisplay];
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
