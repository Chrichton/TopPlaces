//
//  PhotoAnnotation.m
//  TopPlaces
//
//  Created by Heiko Goes on 03.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "PhotoAnnotation.h"
#import "FlickrPhoto.h"
#import "FlickrFetcher.h"

@interface PhotoAnnotation()

@property (nonatomic, readonly) NSString* theTitle;

@end

@implementation PhotoAnnotation

@synthesize photo = _photo, theTitle = _theTitle;

+ CreateWithPhoto: (NSDictionary *) photo {
    PhotoAnnotation *photoAnnotation = [[PhotoAnnotation alloc] init];
    photoAnnotation.photo = photo;
    
    return photoAnnotation;
}

#pragma mark - MKAnnotation

- (NSString *)title
{
    return self.theTitle;
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[self.photo objectForKey:FLICKR_LATITUDE] doubleValue];
    coordinate.longitude = [[self.photo objectForKey:FLICKR_LONGITUDE] doubleValue];
    return coordinate;
}

- (void)setPhoto:(NSDictionary *)photo {
    FlickrPhoto *flickrPhoto = [[FlickrPhoto alloc] initWithPhoto:photo];
    _theTitle = flickrPhoto.title;
    
    _photo = photo;
}

@end
