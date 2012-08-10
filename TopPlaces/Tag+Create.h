//
//  Tag+Create.h
//  TopPlaces
//
//  Created by cp on 10.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.

#import "Tag.h"

@interface Tag (Create)

+ (Tag *)tagWithContent:(NSString *)content inManagedObjectContext:(NSManagedObjectContext *)context;

@end
