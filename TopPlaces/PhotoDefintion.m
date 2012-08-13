//
//  PhotoDefintion.m
//  TopPlaces
//
//  Created by Heiko Goes on 10.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "PhotoDefintion.h"
#import "FlickrPhoto.h"
#import "FlickrFetcher.h"
#import "Place.h"

@implementation PhotoDefintion

@synthesize photoId = _photoId, title = _title, imageURL = _imageURL, placeName = _placeName, tags = _tags;

- (PhotoDefintion *)initWithId: (NSString *)photoId title:(NSString *)title placeName:(NSString *)placeName tags:(NSSet *)tags urlBlock: (ImageUrlBlockType) imageURL {
    self = [super init];
    if (self) {
        _photoId = photoId;
        _title = title;
        _imageURL = imageURL;
        _placeName = placeName;
    }
    
    return self;
}

+ (PhotoDefintion *)createWithFlickrPhoto: (NSDictionary *) photo {
    FlickrPhoto *flickrPhoto = [[FlickrPhoto alloc] initWithPhoto: photo];
    
    NSArray *tagsArray = [[photo objectForKey:FLICKR_TAGS] componentsSeparatedByString:@" "];
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        NSString *tag = evaluatedObject;
        return [tag rangeOfString:@":"].location == NSNotFound;
    }];
    
    tagsArray = [tagsArray filteredArrayUsingPredicate:predicate];
  
    NSMutableSet *tags = [[NSMutableSet alloc] init];
    for (NSString *tag  in tagsArray) {
        NSString *firstChar = [tag substringToIndex:1];
        NSString *upperCaseTag = [[firstChar uppercaseString] isEqualToString:firstChar] ?
            tag : [[firstChar uppercaseString] stringByAppendingString:[tag substringFromIndex:1]];

        [tags addObject:upperCaseTag];
    }
    
    return [[PhotoDefintion alloc] initWithId:flickrPhoto.photoId title:flickrPhoto.title placeName: flickrPhoto.placeName tags: tags urlBlock:^{
        return [FlickrFetcher urlForPhoto:photo format:FlickrPhotoFormatLarge];
    }];
}

+ (PhotoDefintion *)createWithPhoto: (Photo *) photo {
    return [[PhotoDefintion alloc] initWithId:photo.unique title:photo.title placeName:photo.place.name tags: photo.tags urlBlock:^{
       return [NSURL URLWithString: photo.imageURL];
   }];
}
            
@end
