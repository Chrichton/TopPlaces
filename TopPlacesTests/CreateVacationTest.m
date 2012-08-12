//
//  CreateVacationTest.m
//  TopPlaces
//
//  Created by Heiko Goes on 09.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "CreateVacationTest.h"
#import "VacationHelper.h"
#import "Place+Create.h"
#import "Photo.h"
#import "Tag+Create.h"

@implementation CreateVacationTest

- (void)testCreateDefaultVacation {
    BOOL __block finished = NO;
    
    [VacationHelper openVacation:@"My Vacation" usingBlock:^(UIManagedDocument *vacation) {
        Place *place = [Place placeWithName:@"place1" inManagedObjectContext:vacation.managedObjectContext];
        Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:vacation.managedObjectContext];
        photo.unique = @"id1";
        photo.title = @"title1";
        photo.subtitle = @"subtitle1";
        photo.imageURL = @"http://farm8.static.flickr.com/7137/7755492244_15755667c0_b.jpg";
        photo.place = place;
        
        Tag *tag1 =[Tag tagWithContent:@"tag1" inManagedObjectContext:vacation.managedObjectContext];
        [photo addTagsObject:tag1];
        
        Tag *tag2 =[Tag tagWithContent:@"tag2" inManagedObjectContext:vacation.managedObjectContext];
        [photo addTagsObject:tag2];
        
        place = [Place placeWithName:@"place2" inManagedObjectContext:vacation.managedObjectContext];
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:vacation.managedObjectContext];
        photo.unique = @"id2";
        photo.title = @"title2";
        photo.subtitle = @"subtitle2";
        photo.imageURL = @"http://farm9.static.flickr.com/8434/7755388594_cceb2cc3ce_b.jpg";
        photo.place = place;
        [photo addTagsObject:tag2];

        tag1.numberOfPhotos = @1;
        tag2.numberOfPhotos = @2;
        
        [vacation saveToURL:vacation.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
            finished = YES;
        }];
    }];
    
    while (!finished) {
        NSDate *futureTime = [NSDate dateWithTimeIntervalSinceNow:0.1];
        [[NSRunLoop currentRunLoop] runUntilDate:futureTime];
    }
}

@end
