//
//  Place.h
//  TopPlaces
//
//  Created by Heiko Goes on 09.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Place : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSSet *photos;
@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

@end
