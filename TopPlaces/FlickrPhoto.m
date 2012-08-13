//
//  FlickrPhoto.m
//  TopPlaces
//
//  Created by Heiko Goes on 31.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "FlickrPhoto.h"
#import "FlickrFetcher.h"

@implementation FlickrPhoto

@synthesize photoId = _photoId, title = _title, description = _description, placeName = _placeName;

- (FlickrPhoto *) initWithPhoto: (NSDictionary *)photo {
    self = [super init];
    if (self) {
        _photoId = [photo valueForKey:FLICKR_PHOTO_ID];
        _description = [[photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        _placeName = [[photo valueForKeyPath:FLICKR_PHOTO_PLACE_NAME] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        _title = [[photo valueForKey:@"title"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (_title.length == 0) {
            if (_description.length > 0)
                _title = _description;
            else
                _title = self.placeName;
        }
    }
    
    return self;
}

@end
