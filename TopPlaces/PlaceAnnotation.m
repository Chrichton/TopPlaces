//
//  PlaceAnnotation.m
//  TopPlaces
//
//  Created by Heiko Goes on 01.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "PlaceAnnotation.h"
#import "FlickrFetcher.h"
#import "FlickrPlace.h"

@interface PlaceAnnotation()

@property (nonatomic, readonly) NSString* theTitle;
@property (nonatomic, readonly) NSString* theSubtitel;

@end

@implementation PlaceAnnotation
@synthesize place = _place, theTitle = _theTitle, theSubtitel = _theSubtitle;

+ CreateWithPlace: (NSDictionary *) place {
    PlaceAnnotation *placeAnnotation = [[PlaceAnnotation alloc] init];
    placeAnnotation.place = place;
    
    return placeAnnotation;
}

#pragma mark - MKAnnotation

- (NSString *)title
{
    return self.theTitle;
}

- (NSString *)subtitle
{
    return self.theSubtitel;
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[self.place objectForKey:FLICKR_LATITUDE] doubleValue];
    coordinate.longitude = [[self.place objectForKey:FLICKR_LONGITUDE] doubleValue];
    return coordinate;
}

- (void)setPlace:(NSDictionary *)place {
    FlickrPlace *flickrPlace = [[FlickrPlace alloc] initWithPlace:place];
    _theTitle = flickrPlace.city;
    _theSubtitle = [NSString stringWithFormat: @"%@, %@", flickrPlace.country, flickrPlace.region];

    _place = place;
}

@end
