//
//  FlickrPhoto.m
//  TopPlaces
//
//  Created by Heiko Goes on 31.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "FlickrPhoto.h"

@implementation FlickrPhoto

@synthesize title = _title, description = _description;

- (FlickrPhoto *) initWithPhoto: (NSDictionary *)photo {
    self = [super init];
    if (self) {
        _description = [photo valueForKeyPath:@"description._content"];
        
        _title = [photo valueForKey:@"title"];
        if (_title.length == 0) {
            if (_description.length > 0)
                _title = _description;
            else
                _title = NSLocalizedString(@"unknown", @"unknown");
        }
    }
    
    return self;
}

@end
