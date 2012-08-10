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
    
    [VacationHelper openVacation:@"Default Vacation Database" usingBlock:^(UIManagedDocument *vacation) {
        Place *place = [Place placeWithName:@"place1" inManagedObjectContext:vacation.managedObjectContext];
        Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:vacation.managedObjectContext];
        photo.id = @"id1";
        photo.title = @"title1";
        photo.subtitle = @"subtitle1";
        photo.imageURL = @"url1";
        photo.place = place;
        [photo addTagsObject:[Tag tagWithContent:@"tag1" inManagedObjectContext:vacation.managedObjectContext]];
        [photo addTagsObject:[Tag tagWithContent:@"tag2" inManagedObjectContext:vacation.managedObjectContext]];
        
        place = [Place placeWithName:@"place2" inManagedObjectContext:vacation.managedObjectContext];
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:vacation.managedObjectContext];
        photo.id = @"id2";
        photo.title = @"title2";
        photo.subtitle = @"subtitle2";
        photo.imageURL = @"url2";
        photo.place = place;
        [photo addTagsObject:[Tag tagWithContent:@"tag2" inManagedObjectContext:vacation.managedObjectContext]];

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
