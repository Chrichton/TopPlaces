//
//  FlickrData.m
//  TopPlaces
//
//  Created by Heiko Goes on 29.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "FlickrPlace.h"

@implementation FlickrPlace

@synthesize country = _country, region = _region, city = _city;

- (FlickrPlace *) initWithPlace: (NSDictionary *)place {
    self = [super init];
    if (self) {
        NSString *content = [place valueForKey:@"_content"];
        NSArray *listItems = [content componentsSeparatedByString:@", "];

        _city = [listItems objectAtIndex:0];
        
        if ([listItems count] == 2) {
            _country = [listItems objectAtIndex:1];
            _region = _country;
        } else {
            _region = [listItems objectAtIndex:1];
            _country = [listItems objectAtIndex:2];
        }

    }
    
    return self;
}

@end
