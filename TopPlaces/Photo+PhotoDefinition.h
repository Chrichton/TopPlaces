//
//  Photo+PhotoDefinition.h
//  TopPlaces
//
//  Created by Heiko Goes on 12.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "Photo.h"
#import "PhotoDefintion.h"

@interface Photo (PhotoDefinition)

+ (Photo *)photoWithPhotoDefinition: (PhotoDefintion *)photoDefinition
        inManagedObjectContext:(NSManagedObjectContext *)context;

@end
