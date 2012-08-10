//
//  VirtualVacationTableViewController.m
//  TopPlaces
//
//  Created by Heiko Goes on 08.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "VacationPlacesTableViewController.h"
#import "VacationHelper.h"
#import "Place.h"
#import "VacationPhotosTableViewController.h"

@interface VacationPlacesTableViewController ()

@property (nonatomic, strong) UIManagedDocument *vacationDatabase;

@end

@implementation VacationPlacesTableViewController

@synthesize vacationName = _vacationName, vacationDatabase = _vacationDatabase;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"VacationPlacesTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Place *place = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = place.name;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"VacationPlacesToPhotos"]) {
        VacationPhotosTableViewController *controller = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Place *place = [self.fetchedResultsController objectAtIndexPath:indexPath];
        controller.photos = [place.photos allObjects];
    }
}

- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.vacationDatabase.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (void)setVacationName:(NSString *)vacationName {
    if (vacationName != self.vacationName) {
        _vacationName = vacationName;
        [VacationHelper openVacation:vacationName usingBlock:^(UIManagedDocument *vacation) {
            self.vacationDatabase = vacation;
            [self setupFetchedResultsController];
        }];
    }
}

@end
