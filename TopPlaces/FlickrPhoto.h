//
//  FlickrPhoto.h
//  TopPlaces
//
//  Created by Heiko Goes on 31.07.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrPhoto : NSObject

- (FlickrPhoto *) initWithPhoto: (NSDictionary *)photo;

@property (nonatomic, readonly) NSString *photoId;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *description;
@property (nonatomic, readonly) NSString *placeName;

@end
