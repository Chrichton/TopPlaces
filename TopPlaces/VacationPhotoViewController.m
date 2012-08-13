//
//  VacationPhotoViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 12.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "VacationPhotoViewController.h"
#import "VacationHelper.h"

@interface VacationPhotoViewController ()

@end

@implementation VacationPhotoViewController

@synthesize vacationDatabase = _vacationDatabase;

- (IBAction)unVisitClicked:(id)sender {
    [VacationHelper unVisitPhoto:self.photo inVacation:self.vacationDatabase];
    self.photo = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
