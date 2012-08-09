//
//  VacationPlaceTableViewController.m
//  TopPlaces
//
//  Created by cp on 09.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "VirtualVacationTableViewController.h"
#import "VacationPlacesTableViewController.h"

@interface VirtualVacationTableViewController ()

@end

@implementation VirtualVacationTableViewController

@synthesize vacationName = _vacationName;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return TRUE;
}

- (void)setVacationName:(NSString *)vacationName {
    _vacationName = vacationName;
    self.title = vacationName;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"VitualVacationToVacationPlaces"]) {
        VacationPlacesTableViewController *controller = segue.destinationViewController;
        controller.vacationName = self.title;
    }
}

@end
