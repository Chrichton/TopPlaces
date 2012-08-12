//
//  VacationHelper.h
//  TopPlaces
//
//  Created by Heiko Goes on 08.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoDefintion.h"

typedef void (^completion_block_t)(UIManagedDocument *vacation);
typedef void (^check_block_t)(BOOL checkResult);

@interface VacationHelper : NSObject

+ (NSURL *)rootURL;

+ (void)openVacation:(NSString *)vacationName
          usingBlock:(completion_block_t)completionBlock;

+ (void)isPhotoWithId: (NSString *)photoId inVacationWithName: (NSString *)vacationName usingBlock:(check_block_t)checkBlock;

+ (void)visitPhoto: (PhotoDefintion *)photoDefinition inVacationWithName: (NSString *)vacationName;

+ (void)unVisitPhoto: (PhotoDefintion *)photoDefinition inVacationWithName: (NSString *)vacationName;

+ (void)unVisitPhoto: (PhotoDefintion *)photoDefinition inVacation: (UIManagedDocument *)vacation;

@end
