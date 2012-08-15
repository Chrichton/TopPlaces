//
//  TagsTableViewController.m
//  TopPlaces
//
//  Created by cp on 09.08.12.
//  Copyright (c) 2012 Heiko Goes. All rights reserved.
//

#import "VacationTagsTableViewController.h"
#import "VacationHelper.h"
#import "Photo.h"
#import "Tag.h"
#import "VacationPhotosTableViewController.h"

@interface VacationTagsTableViewController ()

@property (nonatomic, strong) UIManagedDocument *vacationDatabase;

@end

@implementation VacationTagsTableViewController

@synthesize vacationName = _vacationName, vacationDatabase = _vacationDatabase;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"VacationTagsTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Tag *tag = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = tag.content;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d photos", [tag.photos count]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"VacationTagsToPhotos"]) {
        VacationPhotosTableViewController *controller = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Tag *tag = [self.fetchedResultsController objectAtIndexPath:indexPath];
        controller.vacationDatabase = self.vacationDatabase;
        controller.photos = [tag.photos allObjects];
    }
}

- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    
    NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"numberOfPhotos" ascending:NO];
    NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"content" ascending:YES selector: @selector(localizedCaseInsensitiveCompare:)];
    request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil];
    
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
