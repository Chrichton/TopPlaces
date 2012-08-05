//
//  Utilities.h
//  TopPlaces
//
//  Created by Heiko Goes on 05.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapUtilities : NSObject

+ (void)zoomMapViewToFitAnnotations:(MKMapView *)mapView animated:(BOOL)animated;

@end
