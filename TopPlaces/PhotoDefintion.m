//
//  PhotoDefintion.m
//  TopPlaces
//
//  Created by Heiko Goes on 10.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "PhotoDefintion.h"
#import "FlickrFetcher.h"
#import "Place.h"

@implementation PhotoDefintion

@synthesize photoId = _photoId, title = _title, subtitle = _subtitle, imageURL = _imageURL, placeName = _placeName, tags = _tags;

- (PhotoDefintion *)initWithId: (NSString *)photoId title:(NSString *)title subtitle:(NSString *)subtitle placeName:(NSString *)placeName tags:(NSSet *)tags urlBlock: (ImageUrlBlockType) imageURL {
    self = [super init];
    if (self) {
        _photoId = photoId;
        _title = title;
        _subtitle = subtitle;
        _imageURL = imageURL;
        _placeName = placeName;
        _tags = tags;
    }
    
    return self;
}

+ (PhotoDefintion *)createWithFlickrPhoto: (NSDictionary *) photo {    
    NSArray *tagsArray = [[photo objectForKey:FLICKR_TAGS] componentsSeparatedByString:@" "];
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        NSString *tag = evaluatedObject;
        return [tag rangeOfString:@":"].location == NSNotFound;
    }];
    
    tagsArray = [tagsArray filteredArrayUsingPredicate:predicate];
  
    NSMutableSet *tags = [[NSMutableSet alloc] init];
    for (NSString *tag  in tagsArray) {
        if (tag.length > 0) {
            NSString *firstChar = [tag substringToIndex:1];
            NSString *upperCaseTag = [[firstChar uppercaseString] isEqualToString:firstChar] ?
            tag : [[firstChar uppercaseString] stringByAppendingString:[tag substringFromIndex:1]];
            
            [tags addObject:upperCaseTag];
        }
    }
    
    NSString *thePhotoId = [photo valueForKey:FLICKR_PHOTO_ID];
    NSString *theDescription = [[photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *thePlaceName = [[photo valueForKeyPath:FLICKR_PHOTO_PLACE_NAME] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *theTitle = [[photo valueForKey:@"title"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (theTitle.length == 0) {
        if (theDescription.length > 0)
            theTitle = theDescription;
        else
            theTitle = thePlaceName;
    }

    return [[PhotoDefintion alloc] initWithId:thePhotoId title:theTitle subtitle: theDescription placeName: thePlaceName tags: tags urlBlock:^{
        return [FlickrFetcher urlForPhoto:photo format:FlickrPhotoFormatLarge];
    }];
}

+ (PhotoDefintion *)createWithPhoto: (Photo *) photo {
    return [[PhotoDefintion alloc] initWithId:photo.unique title:photo.title subtitle: photo.subtitle placeName:photo.place.name tags: photo.tags urlBlock:^{
       return [NSURL URLWithString: photo.imageURL];
   }];
}
            
@end
