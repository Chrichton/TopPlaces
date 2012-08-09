//
//  CreateVacationTest.m
//  TopPlaces
//
//  Created by Heiko Goes on 09.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "CreateVacationTest.h"
#import "VacationHelper.h"

@implementation CreateVacationTest

- (void)testCreateDefaultVacation {
    [VacationHelper openVacation:@"Default Vacation Database" usingBlock:^(UIManagedDocument *vacation) {
       
    }];
}

@end
