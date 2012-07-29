//
//  FlickrData.h
//  TopPlaces
//
//  Created by Heiko Goes on 29.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrPlace : NSObject

- (FlickrPlace *) initWithPlace: (NSDictionary *)place;

@property (nonatomic, readonly) NSString *country;
@property (nonatomic, readonly) NSString *region;
@property (nonatomic, readonly) NSString *city;

@end
