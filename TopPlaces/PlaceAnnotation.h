//
//  PlaceAnnotation.h
//  TopPlaces
//
//  Created by Heiko Goes on 01.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PlaceAnnotation : NSObject<MKAnnotation>

+ CreateWithPlace: (NSDictionary *) place;

@property (nonatomic, strong) NSDictionary *place;

@end
