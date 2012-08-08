//
//  VacationHelper.m
//  TopPlaces
//
//  Created by Heiko Goes on 08.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "VacationHelper.h"

@implementation VacationHelper

+ (void)openVacation:(NSString *)vacationName
          usingBlock:(completion_block_t)completionBlock {

    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:vacationName];
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
