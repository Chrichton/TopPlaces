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

@implementation PhotoDefintion

@synthesize photoId = _photoId, title = _title, imageURL = _imageURL;

- (PhotoDefintion *)initWithId: (NSString *)photoId title:(NSString *)title urlBlock: (ImageUrlBlockType) imageURL {
    self = [super init];
    if (self) {
        _photoId = photoId;
        _title = title;
        _imageURL = imageURL;
    }
    
    return self;
}

+ (PhotoDefintion *)createWithFlickrPhoto: (NSDictionary *) photo {
    FlickrPhoto *flickrPhoto = [[FlickrPhoto alloc] initWithPhoto: photo];
    
    return [[PhotoDefintion alloc] initWithId:flickrPhoto.photoId title:flickrPhoto.title urlBlock:^{
        return [FlickrFetcher urlForPhoto:photo format:FlickrPhotoFormatLarge];
    }];
}

+ (PhotoDefintion *)createWithPhoto: (Photo *) photo {
   return [[PhotoDefintion alloc] initWithId:photo.unique title:photo.title urlBlock:^{
       return [NSURL URLWithString: photo.imageURL];
   }];
}
            
@end
