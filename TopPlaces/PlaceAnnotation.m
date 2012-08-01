//
//  PlaceAnnotation.m
//  TopPlaces
//
//  Created by Heiko Goes on 01.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "PlaceAnnotation.h"
#import "FlickrFetcher.h"

@implementation PlaceAnnotation
@synthesize place = _place;

+ CreateWithPlace: (NSDictionary *) place {
    PlaceAnnotation *placeAnnotation = [[PlaceAnnotation alloc] init];
    placeAnnotation.place = place;
    
    return placeAnnotation;
}

#pragma mark - MKAnnotation

- (NSString *)title
{
    return [self.place objectForKey:FLICKR_PLACE_NAME];
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[self.place objectForKey:FLICKR_LATITUDE] doubleValue];
    coordinate.longitude = [[self.place objectForKey:FLICKR_LONGITUDE] doubleValue];
    return coordinate;
}

@end
