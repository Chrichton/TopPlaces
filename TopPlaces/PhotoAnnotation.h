//
//  PhotoAnnotation.h
//  TopPlaces
//
//  Created by Heiko Goes on 03.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PhotoAnnotation : NSObject<MKAnnotation>

+ CreateWithPhoto: (NSDictionary *) photo;

@property (nonatomic, strong) NSDictionary *photo;

@end
