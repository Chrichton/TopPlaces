//
//  VacationHelper.m
//  TopPlaces
//
//  Created by Heiko Goes on 08.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "VacationHelper.h"
#import <CoreData/CoreData.h>
#import "Photo+PhotoDefinition.h"
#import "Place+Create.h"

@implementation VacationHelper

+ (NSURL *)rootURL {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *url = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:@"vacations"];
    if (![fileManager fileExistsAtPath:[url path]]) {
        NSError *error;
        [fileManager createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:&error];
    }
                                  
    return url;
}

+ (void)openVacation:(NSString *)vacationName
          usingBlock:(completion_block_t)completionBlock {
    NSURL *url = [[self rootURL] URLByAppendingPathComponent:vacationName];
    UIManagedDocument *vacationDatabase = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[vacationDatabase.fileURL path]]) {
        [vacationDatabase saveToURL:vacationDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            completionBlock(vacationDatabase);
        }];
    } else if (vacationDatabase.documentState == UIDocumentStateClosed) {
        [vacationDatabase openWithCompletionHandler:^(BOOL success) {
            completionBlock(vacationDatabase);
        }];
    } else if (vacationDatabase.documentState == UIDocumentStateNormal) {
        completionBlock(vacationDatabase);
    }
}

+ (void)isPhotoWithId: (NSString *)photoId inVacationWithName: (NSString *)vacationName usingBlock:(check_block_t)checkBlock {
    [self openVacation:vacationName usingBlock:^(UIManagedDocument *vacation) {
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Photo"];
        request.predicate = [NSPredicate predicateWithFormat:@"unique =%@", photoId];
        
        NSError *error;
        Photo *photo = [[vacation.managedObjectContext executeFetchRequest:request error:&error] lastObject];
        checkBlock(photo != nil);
    }];
}

+ (void)visitPhoto: (PhotoDefintion *)photoDefinition inVacationWithName: (NSString *)vacationName {
    [self openVacation:vacationName usingBlock:^(UIManagedDocument *vacation) {
        Photo *photo = [Photo photoWithPhotoDefinition:photoDefinition inManagedObjectContext:vacation.managedObjectContext];
        Place *place = [Place placeWithName:photoDefinition.placeName inManagedObjectContext:vacation.managedObjectContext];
        photo.place = place;
        [vacation saveToURL:vacation.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:NULL];
    }];
}

+ (void)unVisitPhoto: (PhotoDefintion *)photoDefinition inVacation: (UIManagedDocument *)vacation {
    Photo *photo = [Photo photoWithPhotoDefinition:photoDefinition inManagedObjectContext:vacation.managedObjectContext];
    [vacation.managedObjectContext deleteObject:photo];
    [vacation saveToURL:vacation.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:NULL];
}

+ (void)unVisitPhoto: (PhotoDefintion *)photoDefinition inVacationWithName: (NSString *)vacationName{
    [self openVacation:vacationName usingBlock:^(UIManagedDocument *vacation) {
        [self unVisitPhoto:photoDefinition inVacation:vacation];
    }];
}

@end
