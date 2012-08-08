//
//  Place+Create.h
//  TopPlaces
//
//  Created by Heiko Goes on 08.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "Place.h"

@interface Place (Create)

+ (Place *)placeWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;

@end
