//
//  VirtualVacationTableViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 08.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "VacationPlacesTableViewController.h"
#import "VacationHelper.h"

@interface VacationPlacesTableViewController ()

@end

@implementation VacationPlacesTableViewController

@synthesize vacationDatabase = _vacationDatabase;

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.vacationDatabase) {
        [VacationHelper openVacation:@"Default Vacation Database" usingBlock:^(UIManagedDocument *vacation) {
            self.vacationDatabase = vacation;
        }];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    return cell;
}

- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.vacationDatabase.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (void)setVacationDatabase:(UIManagedDocument *)vacationDatabase {
    if (vacationDatabase != self.vacationDatabase) {
        _vacationDatabase = vacationDatabase;
        [self setupFetchedResultsController];
    }
}

@end
