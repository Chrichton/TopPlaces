//
//  Photo+Flickr.m
//  TopPlaces
//
//  Created by Heiko Goes on 08.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "Photo+Flickr.h"
#import "FlickrFetcher.h"
#import "Place+Create.h"

@implementation Photo (Flickr)

+ (Photo *)photoWithFlickrData: (NSDictionary *)flickrData
          inManagedObjectContext:(NSManagedObjectContext *)context {
        
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
        request.predicate = [NSPredicate predicateWithFormat:@"Id = %@", [flickrData objectForKey:FLICKR_PHOTO_ID]];
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
        request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        
        NSError *error = nil;
        NSArray *matches = [context executeFetchRequest:request error:&error];
    Photo *photo = nil;
    
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if ([matches count] == 0) {
            photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
            photo.id = [flickrData objectForKey:FLICKR_PHOTO_ID];
            photo.title = [flickrData objectForKey:FLICKR_PHOTO_TITLE];
            photo.subtitle = [flickrData valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
            photo.imageURL = [[FlickrFetcher urlForPhoto:flickrData format:FlickrPhotoFormatLarge] absoluteString];
            photo.place = [Place placeWithName:[flickrData objectForKey:FLICKR_PLACE_NAME] inManagedObjectContext:context];
        } else {
            photo = [matches lastObject];
        }
        
        return photo;
    }

@end
