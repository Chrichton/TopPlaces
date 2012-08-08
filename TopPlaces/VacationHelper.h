//
//  VacationHelper.h
//  TopPlaces
//
//  Created by Heiko Goes on 08.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completion_block_t)(UIManagedDocument *vacation);

@interface VacationHelper : NSObject

+ (void)openVacation:(NSString *)vacationName
          usingBlock:(completion_block_t)completionBlock;

@end
