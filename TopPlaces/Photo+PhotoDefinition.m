//
//  Photo+PhotoDefinition.m
//  TopPlaces
//
//  Created by Heiko Goes on 12.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "Photo+PhotoDefinition.h"
#import "Tag+Create.h"

@implementation Photo (PhotoDefinition)

+ (Photo *)photoWithPhotoDefinition: (PhotoDefintion *)photoDefinition
             inManagedObjectContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", photoDefinition.photoId];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    Photo *photo = nil;
    
    if (!matches || ([matches count] > 1)) {
        // handle error
    } else if ([matches count] == 0) {
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
        photo.unique = photoDefinition.photoId;
        photo.title = photoDefinition.title;
        photo.subtitle = photoDefinition.subtitle;
        photo.imageURL = [photoDefinition.imageURL() absoluteString];
        
        for (NSString *tagContent in photoDefinition.tags) {
            Tag *tag = [Tag tagWithContent:tagContent inManagedObjectContext:context];
            [photo addTagsObject:tag];
            tag.numberOfPhotos = [NSNumber numberWithInt:[tag.numberOfPhotos intValue] + 1];
        }
        
    } else {
        photo = [matches lastObject];
    }
    
    return photo;
}

@end
