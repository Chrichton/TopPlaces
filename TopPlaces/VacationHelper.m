//
//  VacationHelper.m
//  TopPlaces
//
//  Created by Heiko Goes on 08.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "VacationHelper.h"

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

@end
