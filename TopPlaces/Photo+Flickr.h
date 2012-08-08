//
//  Photo+Flickr.h
//  TopPlaces
//
//  Created by Heiko Goes on 08.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "Photo.h"

@interface Photo (Flickr)

+ (Photo *)photoWithFlickrData: (NSDictionary *)flickrData 
        inManagedObjectContext:(NSManagedObjectContext *)context;

@end
