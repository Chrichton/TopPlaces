//
//  PhotoDefintion.h
//  TopPlaces
//
//  Created by Heiko Goes on 10.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface PhotoDefintion : NSObject

typedef NSURL *(^ImageUrlBlockType)();

@property (nonatomic, readonly) NSString *photoId;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) ImageUrlBlockType imageURL;

- (PhotoDefintion *)initWithId: (NSString *)photoId title:(NSString *)title urlBlock: (ImageUrlBlockType) imageURL;

+ (PhotoDefintion *)createWithFlickrPhoto: (NSDictionary *) photo;
+ (PhotoDefintion *)createWithPhoto: (Photo *) photo;

@end
